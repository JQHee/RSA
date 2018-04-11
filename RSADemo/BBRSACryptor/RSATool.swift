//
//  RSATool.swift
//  CloudNews
//
//  Created by macos on 2018/4/11.
//  Copyright © 2018年 macos. All rights reserved.
//

import UIKit
import GTMBase64

fileprivate let pub_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQJMch/pjEYpu/O4CaPejZrqjYWephFgK9B1oN03t0i7kogc7bneW7Al2YFid9IdI7F9jfoL/fK2a96Q3KFzrizNjR+brQHgBPQpPe1rbb30uhhSU48TgVsecJrDz9yOzNeAK1RIsPRgSx9eu4NmyWfvC3RJub+digXXO0VpfJOwIDAQAB"

fileprivate let pri_key = "MIICXQIBAAKBgQDQJMch/pjEYpu/O4CaPejZrqjYWephFgK9B1oN03t0i7kogc7bneW7Al2YFid9IdI7F9jfoL/fK2a96Q3KFzrizNjR+brQHgBPQpPe1rbb30uhhSU48TgVsecJrDz9yOzNeAK1RIsPRgSx9eu4NmyWfvC3RJub+digXXO0VpfJOwIDAQABAoGAZVeS0T1p2ix80oZBHlhIWDyPHw/gazbRTIIY2aR/doZVN6DEO+/MG9qSAWu//FAMURNSV8enxBwYoRyoxx26YDQvYZPM3YnnPzm53nUCSxW6ZUeVuBE3ZFOcPjPabioSjFFg/i9VHWtcfilptXfg9XrP21ZdAis9P1hzW4JY3DECQQDsIwGDsLUmvTirjf8Upp9wuCv0I7Son2U+Be0xHIiY5zobY636J5C7fkxTnTpWPEptHYcb6rNo0BUBGp6wBft5AkEA4ab3SkFjSQ5u+C++YEiKF7WKQ/RvLyDbLJN1vfW0PB9bmpQzgG+aS9Xd55/wtagCvjFDL/Lshx8yNKMvAVAJUwJAFX4WLDNQOadtWggBmJKV3n+U2JLLZbGkWGHXtemf8TLSkh2ffy5MuRQExHOCFMlGCOpwGrVhAQA3eTNAEEtrGQJBAI+epWYtl/O3rAlq2dCOWtYcRZRazyk/0D/e2uG8sKpTiwonqV/lqF78D/CMa7gy5wwGbqzmAIU/5cR62EANoOECQQC4/t+aB4WehyyUH9qyDFO3ipFON/ZTRf+WeaMsbWwoLBy9diJEKvtxDvu3SodiYp9JwLzWURo9OwWKp5d6peQb"

extension String {
    /// 公钥加密
    func rsa_encode() -> String {
        let rsaCryptor = BBRSACryptor()
        rsaCryptor.importRSAPublicKeyBase64(pub_key)
        let enData = self.data(using: String.Encoding.utf8)
        let rsaData = rsaCryptor.encryptWithPublicKey(usingPadding: RSA_PADDING_TYPE.PKCS1, plainData: enData);
        return GTMBase64.string(byEncoding: rsaData)
    }

    /// 私钥解密
    func rsa_decode() -> String {
        let rsaCryptor = BBRSACryptor()
        rsaCryptor.importRSAPrivateKeyBase64(pri_key)
        let endata64 = self.data(using: String.Encoding.utf8)
        let data64 = GTMBase64.decode(endata64)
        let data = rsaCryptor.decryptWithPrivateKey(usingPadding: RSA_PADDING_TYPE.PKCS1, cipherData: data64)
        guard let tempData = data else {
            return ""
        }
        let destr = String(data: tempData, encoding: String.Encoding.utf8)
        return destr ?? ""
    }
}
