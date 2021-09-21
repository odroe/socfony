import { Injectable } from '@nestjs/common';
import dayjs = require('dayjs');
import { customAlphabet, nanoid } from 'nanoid';
import { StorageBox } from 'src/storage-box';
import { StorageBoxInterface } from 'storage-box';
import { VerificationCodeResponse } from './entities/verification-code.response';
import { SmsClient } from './sms-client';
import { VerificationCodeService } from './verification-code.service';

@Injectable()
export class SmsVerificationCodeService {
  constructor(
    @StorageBox('sms') private readonly smsStorageBox: StorageBoxInterface,
    private readonly smsClient: SmsClient,
    private readonly verificationCodeService: VerificationCodeService,
  ) {}

  async send(phone: string): Promise<VerificationCodeResponse> {
    const code = customAlphabet('1234567890', 6)();
    const term = (await this.smsStorageBox.get<number>('term')) || 300;
    const period = (await this.smsStorageBox.get<number>('period')) || 60;
    const context = nanoid();

    const value = await this.verificationCodeService.store({
      context,
      code,
      account: phone,
      expiredAt: dayjs().add(term, 'seconds').toDate(),
    });

    this.smsClient.send(phone, {
      context,
      code,
      term,
    });

    const response: VerificationCodeResponse = new VerificationCodeResponse();
    response.context = context;
    response.expiredAt = value.expiredAt;
    response.period = period;

    return response;
  }
}
