import { forwardRef, Inject, Injectable } from '@nestjs/common';
import { OneTimePasswordType, PrismaClient } from '@prisma/client';
import nodemailer = require('nodemailer');
import { OneTimePasswordService } from '../one-time-password.service';

@Injectable()
export class EmailService {
  constructor(
    private readonly prisma: PrismaClient,
    @Inject(forwardRef(() => OneTimePasswordService))
    private readonly otpService: OneTimePasswordService,
  ) {}

  protected async configure(): Promise<{
    pool: boolean;
    host: string;
    port: number;
    secure: boolean;
    auth: {
      user: string;
      pass: string;
    };
    name: string;
  }> {
    const setting = await this.prisma.setting.findUnique({
      where: {
        type_key: {
          type: 'email',
          key: 'configure',
        },
      },
      rejectOnNotFound: false,
    });

    return setting?.value as unknown as {
      pool: boolean;
      host: string;
      port: number;
      secure: boolean;
      auth: {
        user: string;
        pass: string;
      };
      name: string;
    };
  }

  async transporter() {
    const configure = await this.configure();

    return [
      nodemailer.createTransport(configure),
      configure.auth.user,
      configure.name,
    ] as const;
  }

  async send(email: string): Promise<void> {
    const otp = await this.otpService.save({
      type: OneTimePasswordType.EMAIL,
      value: email,
      // 5 minutes
      expiredAt: new Date(Date.now() + 1000 * 60 * 5),
    });

    const [transporter, from, name] = await this.transporter();

    transporter.sendMail({
      from: `${name} <${from}>`,
      to: email,
      subject: 'One Time Password',
      text: `Your one time password is ${otp}`,
    });
  }
}
