import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { OneTimePasswordType } from '@prisma/client';
import nodemailer = require('nodemailer');
import mailer from 'src/configuration/mailer';
import { OTPCommonService } from '../common';

@Injectable()
export class EmailService {
  constructor(
    private readonly common: OTPCommonService,
    @Inject(mailer.KEY) private readonly configure: ConfigType<typeof mailer>,
  ) {}

  transporter() {
    return nodemailer.createTransport({
      host: this.configure.host,
      port: this.configure.port,
      secure: this.configure.secure,
      auth: {
        user: this.configure.user,
        pass: this.configure.pass,
      },
      name: this.configure.name,
    });
  }

  async send(email: string): Promise<void> {
    const otp = await this.common.save({
      type: OneTimePasswordType.EMAIL,
      value: email,
      // 5 minutes
      expiredAt: new Date(Date.now() + 1000 * 60 * 5),
    });

    this.transporter().sendMail({
      from: `${this.configure.name} <${this.configure.user}>`,
      to: email,
      subject: 'One Time Password',
      text: `Your one time password is ${otp}`,
    });
  }
}
