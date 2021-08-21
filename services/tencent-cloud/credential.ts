import { Credential } from "tencentcloud-sdk-nodejs/tencentcloud/common/interface";
import { tencentCloudStorageBox } from "./storage-box";

export const getCredential = (): Promise<Credential> =>
  tencentCloudStorageBox.get("credential");
