import nodemailer = require('nodemailer');
import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { mailer } from 'src/configuration';

export interface MailerSendOptions {
  password: string;
  expiredAt: Date;
}

@Injectable()
export class MailerService {
  private readonly transporter: nodemailer.Transporter;

  constructor(
    @Inject(mailer.KEY) private readonly configure: ConfigType<typeof mailer>,
  ) {
    this.transporter = nodemailer.createTransport({
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

  async send(email: string, options: MailerSendOptions): Promise<void> {
    const now = new Date();
    const minutes = Math.floor(
      (options.expiredAt.getTime() - now.getTime()) / 1000 / 60,
    );

    this.transporter.sendMail({
      from: `${this.configure.name} <${this.configure.user}>`,
      to: email,
      subject: 'Socfony - 邮件一次性密码',
      text: `您的验证码是${options.password}，该验证码有效期为${minutes}分钟，请不要轻易泄漏验证码给他人！`,
    });
  }
}
