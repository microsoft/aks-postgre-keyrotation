// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

using System.Collections.Generic;

namespace PostgreKeyRotation.Models
{
    public class PostgreSQLConnectResult
    {
        public string SecretMountPoint { get; set; }
        public IEnumerable<SimpleUser> Users { get; set; }
    }
}
