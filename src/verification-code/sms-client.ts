import { Injectable } from '@nestjs/common';
import { StorageBox } from 'src/storage-box';
import { StorageBoxInterface } from 'storage-box';
import { Client } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_client';
import { SendSmsRequest } from 'tencentcloud-sdk-nodejs/tencentcloud/services/sms/v20210111/sms_models';
import { Credential } from 'tencentcloud-sdk-nodejs/tencentcloud/common/interface';
import ms from 'ms';

@Injectable()
export class SmsClient {
    constructor(
        @StorageBox('sms') private readonly smsStorageBox: StorageBoxInterface,
        @StorageBox('vendor') private readonly vendorStorageBox: StorageBoxInterface,
    ) {}

    async #createClient(): Promise<Client> {
        const credential = await this.vendorStorageBox.get<Credential>('tencentcloud');
        const region = await this.smsStorageBox.get<string>('region');

        return new Client({
            credential,
            region,
        });
    }

    async send(phone: string, args: {
        context?: string,
        code: string,
        term: number,
    }): Promise<void> {
        const client = await this.#createClient();
        const params = await this.smsStorageBox.get<Pick<SendSmsRequest, 'ExtendCode' | 'SenderId' | 'SignName' | 'SmsSdkAppId' | 'TemplateId' | 'TemplateParamSet'>>('params');

        const templateParamSet = params.TemplateParamSet.map(param => param.replace('{code}', args.code).replace('{term}', ms(args.term * 1000, { long: true })));

        await client.SendSms({
            ...params,
            PhoneNumberSet: [phone],
            SessionContext: args.context,
            TemplateParamSet: templateParamSet,
        });
    }
}
