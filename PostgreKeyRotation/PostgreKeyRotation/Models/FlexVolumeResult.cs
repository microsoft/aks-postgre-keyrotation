// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

using System;

namespace PostgreKeyRotation.Models
{
    public class FlexVolumeResult
    {
        public DateTime? MountFileLastModified { get; set; }
        public string MountFileContents { get; set; }
        public DateTime? KeyVaultSecretLastModified { get; set; }
        public string KeyVaultSecretContents { get; set; }
    }
}
