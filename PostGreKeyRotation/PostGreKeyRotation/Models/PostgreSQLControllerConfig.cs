using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PostGreKeyRotation.Models
{
    public class PostgreSQLControllerConfig
    {
        public string ConnectionStringRoleName { get; set; }
        public string ConnectionStringPwdMountPoint { get; set; }
        public string ConnectionStringTemplate { get; set; }
    }
}
