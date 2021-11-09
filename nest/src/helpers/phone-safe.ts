import { parsePhoneNumber } from "libphonenumber-js";

export function phoneSafeParse(phone: string): string {
    const result = parsePhoneNumber(phone);

    return '+' +
           result.countryCallingCode + 
           result.nationalNumber.replace(/(\d{3})\d*(\d{4})/, '$1****$2');
}