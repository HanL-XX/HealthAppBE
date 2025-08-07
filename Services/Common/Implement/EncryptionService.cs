using Common.Helpers;
using DTOs.Models;
using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Services.Common
{
    public class EncryptionService
    {
        public AES_DTO AES_Encryption(string original, byte[] aesIV, byte[] aesKey)
        {
            AES_DTO dto = new AES_DTO();

            using (Aes myAes = Aes.Create())
            {
                // Encrypt the string to an array of bytes.
                dto.IV = aesIV;
                dto.Key = aesKey;
                dto.Encrypted = UtilService.EncodeTo64(EncryptStringToBytes_Aes(original, dto.Key, dto.IV));
            }

            return dto;
        }

        public AES_DTO AES_Encryption(string original)
        {
            AES_DTO dto = new AES_DTO();

            var key = Settings.DECRYPTIONKEY;

            using (Aes myAes = Aes.Create())
            {
                // Encrypt the string to an array of bytes.
                dto.IV = new byte[16];
                dto.Key = Encoding.UTF8.GetBytes(key) ?? myAes.Key;
                dto.Encrypted = UtilService.EncodeTo64(EncryptStringToBytes_Aes(original, dto.Key, dto.IV));
            }

            return dto;
        }

        private static byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
        {
            // Check arguments.
            if (string.IsNullOrEmpty(plainText))
            {
                throw new ArgumentNullException("plainText");
            }

            if (Key == null || Key.Length <= 0)
            {
                throw new ArgumentNullException("C");
            }

            if (IV == null || IV.Length <= 0)
            {
                throw new ArgumentNullException("IV");
            }

            byte[] encrypted;

            // Create an Aes object
            // with the specified key and IV.
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Create an encryptor to perform the stream transform.
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(Key, IV);

                // Create the streams used for encryption.
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt = new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }

            // Return the encrypted bytes from the memory stream.
            return encrypted;
        }

        public string AES_Description(string Encrypted, byte[] key, byte[] IV)
        {
            return DecryptStringFromBytes_Aes(Convert.FromBase64String(Encrypted), key, IV); // sao nó vang
        }

        private static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Check arguments.
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");

            // Declare the string used to hold
            // the decrypted text.
            string plaintext = null;

            // Create an Aes object
            // with the specified key and IV.
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Create a decryptor to perform the stream transform.
                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                // Create the streams used for decryption.
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {

                            // Read the decrypted bytes from the decrypting stream
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }
            return plaintext;
        }

        public void GenerateAesIVAndKey(out byte[] aesIV, out byte[] aesKey)
        {
            using (Aes myAes = Aes.Create())
            {
                myAes.GenerateIV();
                myAes.GenerateKey();

                aesIV = myAes.IV;
                aesKey = myAes.Key;
            }
        }
    }
}
