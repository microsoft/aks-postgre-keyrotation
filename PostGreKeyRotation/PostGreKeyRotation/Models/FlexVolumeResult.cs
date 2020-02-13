using System;

namespace PostGreKeyRotation.Models
{
    public class FlexVolumeResult
    {
        public DateTime? MountFileLastModified { get; set; }
        public string MountFileContents { get; set; }
        public DateTime? KeyVaultSecretLastModified { get; set; }
        public string KeyVaultSecretContents { get; set; }
    }
}
