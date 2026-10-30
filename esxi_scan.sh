#!/bin/sh
# ESXi 6.5.0 build 7388607: original log collection modules + UNC3886 hunting.
# Read-only checks. No guest/VMDK inspection or recursive datastore scan.
# NOTE: Preserves the original full /var/log and /scratch/log copy behavior.
umask 077

#ESXi for IR
output=ESXi_Logs_$(hostname -i 2>/dev/null | awk '{print $1}')_$(hostname)_$(date +%F_%H-%M-%S)
workdir=$(pwd)
mkdir -p "$output" || exit 1
BASE_DIR="$workdir/$output"
cd "$output" || exit 1

echo -e uname -a >> ESXi-systeminfo-results.txt 2>> err
uname -a >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "hostname" >> ESXi-systeminfo-results.txt 2>> err
hostname >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "cat /etc/resolv.conf" >> ESXi-systeminfo-results.txt 2>> err
cat /etc/resolv.conf >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "esxcfg-vmknic -l" >> ESXi-systeminfo-results.txt 2>> err
esxcfg-vmknic -l >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ps -Tcjstv" >> ESXi-process-results.txt 2>> err
ps -Tcjstv >> ESXi-process-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-process-results.txt 2>> err

echo -e "Process detail list" >> ESXi-process-results.txt 2>> err
ps -Tcjstv | grep "/" | grep -v "/bin/vmx" | grep -v "rhttpproxy" | grep -v "hostd-worker" | grep -v "/etc/vmware/vpxa" | grep -v "/usr/lib/vmware" | grep -v "/opt/vmware/fdm" >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-process-results.txt 2>> err

echo -e "Opening port list" >> ESXi-systeminfo-results.txt 2>> err
esxcli network ip connection list | grep -i "listen\|udp" | awk '{print $4"/"$1"/"$9}' | awk -F ':' '{print $NF}' | sort | uniq >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "All listening" >> ESXi-systeminfo-results.txt 2>> err
esxcli network ip connection list | grep -i listen >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "All connection" >> ESXi-systeminfo-results.txt 2>> err
esxcli network ip connection list >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "Current login sessions" >> ESXi-systeminfo-results.txt 2>> err
who >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "cat /etc/passwd" >> ESXi-systeminfo-results.txt 2>> err
cat /etc/passwd >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "cat /etc/sudoers" >> ESXi-systeminfo-results.txt 2>> err
cat /etc/sudoers >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -lah /var/spool/cron/crontabs" >> ESXi-systeminfo-results.txt 2>> err
ls -lah /var/spool/cron/crontabs >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "cat /var/spool/cron/crontabs/root" >> ESXi-systeminfo-results.txt 2>> err
cat /var/spool/cron/crontabs/root >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -lahtr /etc/init.d/" >> ESXi-systeminfo-results.txt 2>> err
ls -lahtr /etc/init.d/ >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -latr /etc/profile" >> ESXi-systeminfo-results.txt 2>> err
ls -latr /etc/profile >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "cat /etc/profile" >> ESXi-systeminfo-results.txt 2>> err
cat /etc/profile >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -latr /etc/environment" >> ESXi-systeminfo-results.txt 2>> err
ls -latr /etc/environment >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "cat /etc/environment" >> ESXi-systeminfo-results.txt 2>> err
cat /etc/environment >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -latr /etc/bashrc" >> ESXi-systeminfo-results.txt 2>> err
ls -latr /etc/bashrc >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "cat /etc/bashrc" >> ESXi-systeminfo-results.txt 2>> err
cat /etc/bashrc >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -latr /etc/init.d/" >> ESXi-systeminfo-results.txt 2>> err
ls -latr /etc/init.d/ >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -latr /etc/rc*.d/" >> ESXi-systeminfo-results.txt 2>> err
ls -latr /etc/rc*.d/ >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -lah /lib/libxselinux" >> ESXi-systeminfo-results.txt 2>> err
ls -lah /lib/libxselinux >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "ls -lah /lib/libxselinux.so" >> ESXi-systeminfo-results.txt 2>> err
ls -lah /lib/libxselinux.so >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "ls -lah /lib64/libxselinux.so" >> ESXi-systeminfo-results.txt 2>> err
ls -lah /lib64/libxselinux.so >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "ls -lahtr /var/lib" >> ESXi-systeminfo-results.txt 2>> err
ls -lahtr /var/lib >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "ls -lahtr /tmp" >> ESXi-systeminfo-results.txt 2>> err
ls -lahtr /tmp >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "ls -lahtr /var/tmp" >> ESXi-systeminfo-results.txt 2>> err
ls -lahtr /var/tmp >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "ls -lahtr /scratch/var/tmp" >> ESXi-systeminfo-results.txt 2>> err
ls -lahtr /scratch/var/tmp >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo -e "esxcli network firewall get" >> ESXi-systeminfo-results.txt 2>> err
esxcli network firewall get >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err
echo -e "esxcli network firewall ruleset rule list" >> ESXi-systeminfo-results.txt 2>> err
esxcli network firewall ruleset rule list >> ESXi-systeminfo-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-systeminfo-results.txt 2>> err

echo 'cat /var/log/auth.log | grep -i "accept"' >> ESXi-login-results.txt 2>> err
cat /var/log/auth.log | grep -i "accept" | awk '{print "Login succeeded: "$1" -- "$6" -- "$8":"$10" -- "$11}' >> ESXi-login-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-login-results.txt 2>> err
echo 'cat /var/log/auth.log | grep -i "fail"' >> ESXi-login-results.txt 2>> err
cat /var/log/auth.log | grep -i "fail" | grep -i "error" | awk '{print "Login failed: "$1" -- "$8" -- "$10}' >> ESXi-login-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-login-results.txt 2>> err

echo -e "cat /var/log/auth.log | more" >> ESXi-login-results.txt 2>> err
cat /var/log/auth.log >> ESXi-login-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-login-results.txt 2>> err

echo -e "cat /var/log/shell.log" >> ESXi-shell-results.txt 2>> err
cat /var/log/shell.log >> ESXi-shell-results.txt 2>> err
echo -e "-------------------------------------" >> ESXi-shell-results.txt 2>> err



# Preserve original full log collection modules.
cp -r /var/log ./var_log 2>> err
cp -r /scratch/log ./scratch_log 2>> err
cd "$workdir/$output" || exit 1


# ==================== UNC3886 HUNTING MODULE ==================== #
run_hunt() {

umask 077
VERSION="1.0"
TS="$(date +%Y%m%d_%H%M%S 2>/dev/null || echo unknown_time)"
HOST="$(hostname 2>/dev/null | sed 's/\//__/g')"
OUT_BASE="$BASE_DIR/hunting"
mkdir -p "$OUT_BASE" 2>/dev/null || return 1
REPORT="$OUT_BASE/report.txt"
IOC_FILE="$OUT_BASE/hash_iocs.txt"
HITS="$OUT_BASE/hash_hits.csv"
PATH_HITS="$OUT_BASE/path_hits.txt"
LOG_HITS="$OUT_BASE/log_hits.txt"
NET_HITS="$OUT_BASE/network_hits.txt"
STATE="$OUT_BASE/state_checks.txt"

say() { echo "$*" >> "$REPORT"; }
section() { say ""; say "===== $* ====="; }

cat > "$IOC_FILE" <<'IOC'
# filename|md5|family|role
# MD5 indicators published in the source article
# Use exact MD5 matching; filenames alone are contextual indicators.
gl.py|381b7a2a6d581e3482c829bfb542a7de|UTILITY|Utility
install-20220615.py|876787f76867ecf654019bd19409c5b8|INSTALLER|Installer
lsuv2_nv.v01|827d8ae502e3a4d56e6c3a238ba855a7|ARCHIVE|Archive
payload1.v00|9ea86dccd5bbde47f8641b62a1eeff07|VIRTUALPITA|VIB payload
vmware_rhttpio.sh|9d5cc1ee99ccb1ec4d20be1cee10173e|VIRTUALPITA|Deployment script
rhttpproxy-io|2c28ec2d541f555b2838099ca849f965|VIRTUALPITA|Backdoor
rdt|8e80b40b1298f022c7f3a96599806c43|VIRTUALPITA|Backdoor
rdt|fcb742b507e3c074da5524d1a7c80f7f|ARCHIVE|Archive
sendPacket.py|129ba90886c5f5eb0c81d901ad10c622|UTILITY|Utility
sendPacket.py|0f76936e237bd87dfa2378106099a673|UTILITY|Utility
u.py|d18a5f1e8c321472a31c27f4985834a4|UTILITY|Utility
vmware_ntp.sh|4ddca39b05103aeb075ebb0e03522064|LAUNCHER|Launcher
wp|0e43a0f747a60855209b311d727a20bf|GHOSTTOWN|Utility
aububbaditd|1d89b48548ea1ddf0337741ebdb89d92|LOOKOVER|Sniffer
bubba_sniffer|ecb34a068eeb2548c0cbe2de00e53ed2|LOOKOVER|Sniffer
ksbubba|89339821cdf6e9297000f3e6949f0404|MOPSLED.LINUX|Backdoor
ksbubba.service|c870ea6a598c12218e6ac36d791032b5|MOPSLED.LINUX|Launcher
99-bubba.rules|1079d416e093ba40aa9e95a4c2a5b61f|REPTILE|Launcher
admin|ed9be20fea9203f4c4557c66c5b9686c|REPTILE|Backdoor
authd|568074d60dd4759e963adc5fe9f15eb1|REPTILE|Backdoor
bubba|4d5e4f64a9b56067704a977ed89aa641|REPTILE|Launcher
bubba_icmp|1b7aee68f384e252286559abc32e6dd1|REPTILE|Backdoor
bubba_loader|b754237c7b5e9461389a6d960156db1e|REPTILE|Backdoor
client|f41ad99b8a8c95e4132e850b3663cb40|REPTILE|Backdoor
dash|48f9bbdb670f89fce9c51ad433b4f200|REPTILE|Launcher
listener|4fb72d580241f27945ec187855efd84a|REPTILE|Backdoor
packet|e2cdf2a3380d0197aa11ff98a34cc59e|REPTILE|Controller
authdd|fd3834d566a993c549a13a52d843a4e1|REPTILE.SHELL|Backdoor
authdd|4282de95cc54829d7ac275e436e33b78|REPTILE.SHELL|Backdoor
bubba_reverse|c9c00c627015bd78fda22fa28fd11cd7|REPTILE.SHELL|Backdoor
unknown|047ac6aebe0fe80f9f09c5c548233407|REPTILE.SHELL|Backdoor
usbubbaxd|bca2ccff0596a9f102550976750e2a89|RIFLESPINE|Backdoor
audit|3a8a60416b7b0e1aa5d17eefb0a45a16|TINYSHELL|Controller
lang_ext|6e248f5424810ea67212f1f2e4616aa5|TINYSHELL|Backdoor
sync|5d232b72378754f7a6433f93e6380737|TINYSHELL|Controller
x64|3c7316012cba3bbfa8a95d7277cda873|VIRTUALGATE|Dropper
ndc4961|9c428a35d9fc1fdaf31af186ff6eec08|VIRTUALPEER|Utility
lsu_lsi_.v05|2716c60c28cf7f7568f55ac33313468b|VIRTUALPIE|VIB payload
vmware_local.sh|bd6e38b6ff85ab02c1a4325e8af29ce4|VIRTUALPIE|Deployment script
rdt|8e80b40b1298f022c7f3a96599806c43|VIRTUALPITA|Backdoor
vmsyslog.py|61ab3f6401d60ec36cd3ac980a8deb75|VIRTUALPIE|Backdoor
vmsyslog.py|61ab3f6401d60ec36cd3ac980a8deb75|VIRTUALPIE|Backdoor
vmware_local.sh|bd6e38b6ff85ab02c1a4325e8af29ce4|VIRTUALPIE|Launcher
cleanupStatefulHost.sh|9ef5266a9fdd25474227c3e33b8e6d77|VIRTUALPITA|Launcher
client|a7cd7b61d13256f5478feb28ab34be72|VIRTUALPITA|Backdoor
duci|cd3e9e4df7e607f4fe83873b9d1142e3|VIRTUALPITA|Backdoor
payload1|62bed88bd426f91ddbbbcfcd8508ed6a|VIRTUALPITA|Archive
rdt|8e80b40b1298f022c7f3a96599806c43|VIRTUALPITA|Backdoor
rhttpproxy|c9f2476bf8db102fea7310abadeb9e01|VIRTUALPITA|Backdoor
rhttpproxy-IO|2c28ec2d541f555b2838099ca849f965|VIRTUALPITA|Backdoor
rpci|2bade2a5ec166d3a226761f78711ce2f|VIRTUALPITA|Backdoor
ssh|969d7f092ed05c72f27eef5f2c8158d6|VIRTUALPITA|Backdoor
nds4961l.so|084132b20ed65b2930129b156b99f5b3|VIRTUALSHINE|Backdoor
IOC

echo 'path,md5,expected_md5,family,role' > "$HITS"
: > "$PATH_HITS"; : > "$LOG_HITS"; : > "$NET_HITS"; : > "$STATE"

section "RUN METADATA"
say "Version: $VERSION"
say "Host: $HOST"
say "Timestamp: $TS"
say "Output: $OUT_BASE"
say "Mode: read-only; no recursive datastore/VMDK scan"
say ""
say "NOTE: ESXi host checks do not inspect files inside guest OS filesystems or vCenter Appliance."

section "ESXi VERSION / BUILD"
vmware -vl >> "$REPORT" 2>&1

section "TARGETED FILE AND HASH CHECKS"
# Only search these system locations. Do NOT traverse /vmfs/volumes or VM disks.
# Include article-specific paths even if parent directories do not exist.
EXACT_PATHS="/etc/rc.local.d/vmware_local.sh /etc/rc.local.d/vmware_rhttpio.sh /bin/rdt /bin/vmsyslog.py /usr/lib/vmware/weasel/consoleui/rhttpproxy-io /usr/libexec/setconf/ksmd /usr/bin/ksmd /var/log/sysclog /var/lib/fwupdd /lib/modules /usr/lib/locate /usr/lib/libseconf /usr/sbin/libvird /usr/bin/NetworkManage /usr/bin/tac_plus /var/run/cron.data /var/run/cron.dat /var/log/remote.txt /tmp/orbit.txt /dev/vsock /vmfs/devices/char/vsock/vsock"
for p in $EXACT_PATHS; do
  if [ -e "$p" ] || [ -L "$p" ]; then
    ls -ld "$p" >> "$PATH_HITS" 2>&1
    [ -d "$p" ] && ls -la "$p" >> "$PATH_HITS" 2>&1
  fi
done
# Optimized filename-first hashing:
# Search only selected OS directories and hash files whose basename is an IOC filename.
# Never recurse into /vmfs/volumes, VMFS datastores, VM folders, or VMDKs.
CANDIDATES="$OUT_BASE/.hash_candidates"
MATCH_TMP="$OUT_BASE/.hash_matches"
: > "$CANDIDATES"
: > "$MATCH_TMP"
for d in /bin /sbin /usr/bin /usr/sbin /etc/rc.local.d /etc/init.d /var/run; do
  [ -d "$d" ] || continue
  find "$d" -type f \( \
    -name gl.py -o -name install-20220615.py -o -name lsuv2_nv.v01 -o -name payload1.v00 -o \
    -name vmware_rhttpio.sh -o -name rhttpproxy-io -o -name rdt -o -name sendPacket.py -o \
    -name u.py -o -name vmware_ntp.sh -o -name wp -o -name aububbaditd -o -name bubba_sniffer -o \
    -name ksbubba -o -name ksbubba.service -o -name 99-bubba.rules -o -name admin -o -name authd -o \
    -name bubba -o -name bubba_icmp -o -name bubba_loader -o -name client -o -name dash -o \
    -name listener -o -name packet -o -name authdd -o -name bubba_reverse -o -name unknown -o \
    -name usbubbaxd -o -name audit -o -name lang_ext -o -name sync -o -name x64 -o -name ndc4961 -o \
    -name lsu_lsi_.v05 -o -name vmware_local.sh -o -name vmsyslog.py -o -name cleanupStatefulHost.sh -o \
    -name duci -o -name payload1 -o -name rhttpproxy -o -name rhttpproxy-IO -o -name rpci -o \
    -name ssh -o -name nds4961l.so \) -print 2>/dev/null >> "$CANDIDATES"
done
# Include known article-specific paths explicitly, without walking their parent trees.
for f in /usr/lib/vmware/weasel/consoleui/rhttpproxy-io /usr/libexec/setconf/ksmd /usr/bin/ksmd \
         /etc/rc.local.d/vmware_local.sh /etc/rc.local.d/vmware_rhttpio.sh /bin/rdt /bin/vmsyslog.py; do
  [ -f "$f" ] && echo "$f" >> "$CANDIDATES"
done
sort -u "$CANDIDATES" > "$CANDIDATES.sorted" 2>/dev/null && mv "$CANDIDATES.sorted" "$CANDIDATES"
while IFS= read -r f; do
  [ -f "$f" ] || continue
  b=${f##*/}
  if command -v md5sum >/dev/null 2>&1; then
    got=$(md5sum "$f" 2>/dev/null | awk '{print tolower($1)}')
  elif command -v md5 >/dev/null 2>&1; then
    got=$(md5 "$f" 2>/dev/null | awk '{print tolower($NF)}')
  else
    got="MD5_TOOL_UNAVAILABLE"
  fi
  [ -n "$got" ] || continue
  awk -F '|' -v n="$b" -v h="$got" -v p="$f" \
    '$1 == n && tolower($2) == h { printf "%s|%s|%s|%s|%s\n", p, h, $2, $3, $4 }' \
    "$IOC_FILE" >> "$MATCH_TMP"
done < "$CANDIDATES"
while IFS='|' read -r p got expected family role; do
  [ -n "$p" ] || continue
  printf 'MATCH: %s (%s) %s/%s\n' "$p" "$got" "$family" "$role" >> "$PATH_HITS"
  printf '\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n' "$p" "$got" "$expected" "$family" "$role" >> "$HITS"
done < "$MATCH_TMP"
rm -f "$CANDIDATES" "$MATCH_TMP"

# Check explicit paths and record metadata only; do not hash directories recursively.
for f in /etc/rc.local.d/vmware_local.sh /etc/rc.local.d/vmware_rhttpio.sh /bin/rdt /bin/vmsyslog.py \
         /usr/lib/vmware/weasel/consoleui/rhttpproxy-io /usr/libexec/setconf/ksmd /usr/bin/ksmd \
         /var/log/sysclog /var/lib/fwupdd /usr/lib/locate /usr/lib/libseconf /var/run/cron.data \
         /var/run/cron.dat /var/log/remote.txt /tmp/orbit.txt /dev/vsock /vmfs/devices/char/vsock/vsock; do
  if [ -e "$f" ] || [ -L "$f" ]; then
    ls -ld "$f" >> "$PATH_HITS" 2>&1
  fi
done

# Metadata for selected persistence locations; no recursive directory/content walk.
for d in /etc/rc.local.d /etc/init.d /etc/rc.d /etc/vmware /var/lib/fwupdd /usr/lib/locate /usr/lib/libseconf /lib/modules; do
  [ -e "$d" ] || continue
  ls -ld "$d" >> "$PATH_HITS" 2>&1
done
for f in /etc/rc.local.d/local.sh /etc/rc.local.d/vmware_local.sh /etc/rc.local.d/vmware_rhttpio.sh \
         /etc/profile /etc/environment /etc/bashrc /etc/init.d/hostd /etc/init.d/vpxa \
         /var/run/cron.data /var/run/cron.dat /usr/lib/locate/.boot.sh /usr/lib/locate/.pts \
         /usr/lib/libseconf/local.txt /var/lib/libsyslog.so /var/log/remote.txt /tmp/orbit.txt; do
  [ -f "$f" ] || continue
  grep -n -E 'fwupdd|bubba|reptile|medusa|mopsled|riflespine|virtualshine|virtualpita|virtualpeer|vmsyslog|libvird|NetworkManage|sshdng-venter|cron\.data|cron\.dat|Centos_Selinux_Config_And_Module|LD_PRELOAD|vmware_local|vmware_rhttpio|sysclog' "$f" 2>/dev/null >> "$PATH_HITS"
done

section "RUNNING PROCESSES / MODULES / VMCI"
{
  echo '--- ps'; ps 2>&1
  echo '--- loaded modules'; esxcli system module list 2>&1
  echo '--- network connections'; esxcli network ip connection list 2>&1
  echo '--- article-related TCP/UDP ports (review context only)'; esxcli network ip connection list 2>&1 | grep -E '(^|[^0-9])(2233|546|18098)([^0-9]|$)' 
  echo '--- VIB list (read-only)'; esxcli software vib list 2>&1
  echo '--- VIB signature verification (read-only; older/upgraded hosts may report unavailable signatures)'; esxcli software vib signature verify 2>&1
  echo '--- ESXi acceptance level'; esxcli software acceptance get 2>&1
  echo '--- bootbank / altbootbank directory metadata only'; ls -ld /bootbank /altbootbank 2>&1
  echo '--- vsock paths'; ls -l /dev/vsock /vmfs/devices/char/vsock/vsock 2>&1
  echo '--- article-related files'; ls -l /etc/rc.local.d/vmware_local.sh /etc/rc.local.d/vmware_rhttpio.sh /bin/rdt /bin/vmsyslog.py /usr/lib/vmware/weasel/consoleui/rhttpproxy-io /var/log/sysclog 2>&1
  echo '--- suspicious process/name patterns'; ps 2>/dev/null | grep -E 'bubba|reptile|medusa|mopsled|riflespine|virtualshine|virtualpita|virtualpeer|vmsyslog|libvird|NetworkManage|sshdng-venter|lookover|ghosttown|/bin/rdt|vmware_local|vmware_rhttpio' | grep -v grep
} >> "$STATE"

section "NETWORK IOC MATCHES"
IP_FILE="$OUT_BASE/network_iocs.txt"
cat > "$IP_FILE" <<'IPS'
8.222.218.20
8.222.216.144
8.219.131.77
8.219.0.112
8.210.75.218
8.210.103.134
47.252.54.82
47.251.46.35
47.246.68.13
47.243.116.155
47.241.56.157
45.77.106.183
45.32.252.98
207.246.64.38
149.28.122.119
155.138.161.47
154.216.2.149
103.232.86.217
103.232.86.210
103.232.86.209
58.64.204.165
58.64.204.142
58.64.204.139
165.154.7.145
165.154.135.108
165.154.134.40
152.32.231.251
152.32.205.208
152.32.144.15
152.32.129.162
123.58.207.86
123.58.196.34
118.193.63.40
118.193.61.71
118.193.61.178
IPS

# Current connection table is usually small; matching only current state avoids packet capture/load.
esxcli network ip connection list 2>/dev/null | while IFS= read -r line; do
  for ip in $(cat "$IP_FILE"); do
    case "$line" in *"$ip"*) echo "IOC_IP_MATCH: $line" >> "$NET_HITS" ;; esac
  done
done
# DNS dead-drop from article; do not treat generic GitHub/Google Drive usage as IOC by itself.
cat > "$OUT_BASE/domain_iocs.txt" <<'DOMAINS'
cyberponke.github.io
DOMAINS
# Article-specific ports and artifacts; observations are indicators for review, not proof alone.
echo '2233|VIRTUALPITA TCP listener (article)' > "$OUT_BASE/article_network_indicators.txt"
echo '546|VIRTUALPIE IPv6 listener (article)' >> "$OUT_BASE/article_network_indicators.txt"
echo '18098|VIRTUALPITA VMCI socket (article)' >> "$OUT_BASE/article_network_indicators.txt"
echo 'sysclog|Possible VMCI activity log artifact (article)' >> "$OUT_BASE/article_network_indicators.txt"

section "RECENT LOG IOA SEARCH"
# Scan only the tail of relevant log files to cap I/O. Adjust LOG_TAIL_LINES if needed.
LOG_TAIL_LINES=5000
LOGS="/var/log/hostd.log /var/log/vpxa.log /var/log/vmkernel.log /var/log/vobd.log /var/log/auth.log /var/log/syslog.log /var/log/shell.log /var/log/esxupdate.log /var/log/sysclog"
PATTERN='cyberponke|8\.222\.218\.20|8\.222\.216\.144|8\.219\.131\.77|8\.219\.0\.112|8\.210\.75\.218|8\.210\.103\.134|47\.252\.54\.82|47\.251\.46\.35|47\.246\.68\.13|47\.243\.116\.155|47\.241\.56\.157|45\.77\.106\.183|45\.32\.252\.98|207\.246\.64\.38|149\.28\.122\.119|155\.138\.161\.47|154\.216\.2\.149|103\.232\.86\.217|103\.232\.86\.210|103\.232\.86\.209|58\.64\.204\.165|58\.64\.204\.142|58\.64\.204\.139|165\.154\.7\.145|165\.154\.135\.108|165\.154\.134\.40|152\.32\.231\.251|152\.32\.205\.208|152\.32\.144\.15|152\.32\.129\.162|123\.58\.207\.86|123\.58\.196\.34|118\.193\.63\.40|118\.193\.61\.71|118\.193\.61\.178|GuestOperations|StartProgramInGuest|ListFilesInGuest|ListProcessesInGuest|authentication failure|Failed password|Invalid user|Accepted password|insmod|LD_PRELOAD|cron\.data|cron\.dat|fwupdd|bubba|reptile|medusa|mopsled|riflespine|virtualshine|virtualpita|virtualpeer|vmsyslog|libvird|NetworkManage|sshdng-venter|/tmp/orbit\.txt|/var/lib/libsyslog\.so|tac_cisco_|TKEY|SNFILENAME|vmware_local|vmware_rhttpio|/bin/rdt|vmsyslog\.py|rhttpproxy-io|sysclog|2233|18098|546'
for f in $LOGS; do
  [ -f "$f" ] || continue
  echo "--- LOG: $f (last $LOG_TAIL_LINES lines)" >> "$LOG_HITS"
  tail -n "$LOG_TAIL_LINES" "$f" 2>/dev/null | grep -i -E "$PATTERN" >> "$LOG_HITS"
done

section "STATIC STRING / FILE INDICATOR SEARCH"
# Search only small, known configuration/script areas; never scan datastore contents.
for f in /etc/rc.local.d/local.sh /etc/rc.local.d/vmware_local.sh /etc/rc.local.d/vmware_rhttpio.sh \
         /etc/rc.local.d/rc.local /etc/profile /etc/bashrc /etc/environment \
         /etc/inetd.conf /etc/hosts.allow /etc/hosts.deny /etc/ssh/sshd_config \
         /etc/init.d/hostd /etc/init.d/vpxa /var/run/cron.data /var/run/cron.dat; do
  [ -f "$f" ] || continue
  grep -n -E 'cyberponke\.github\.io|/tmp/orbit\.txt|/usr/lib/locate/\.boot\.sh|/usr/lib/locate/\.pts|/usr/lib/libseconf/local\.txt|/var/log/remote\.txt|/var/lib/libsyslog\.so|/var/run/cron\.data|/var/run/cron\.dat|Centos_Selinux_Config_And_Module|sshdng-venter-7\.0|TKEY|SNFILENAME|LD_PRELOAD|bubba_reverse|bubba_icmp|usbubbaxd|ksbubba' "$f" 2>/dev/null >> "$PATH_HITS"
done

section "SUMMARY"
{
  echo "Output directory: $OUT_BASE"
  echo "Hash IOC matches: $(grep -c '^MATCH:' "$PATH_HITS" 2>/dev/null)"
  echo "Network IOC matches in current connections: $(wc -l < "$NET_HITS" | sed 's/ //d')"
  echo "Log IOA matches: $(wc -l < "$LOG_HITS" | sed 's/ //d')"
  echo "Files: report.txt, hash_iocs.txt, hash_hits.csv, path_hits.txt, log_hits.txt, network_hits.txt, state_checks.txt, network_iocs.txt, domain_iocs.txt"
  echo ""
  echo "Limitations:"
  echo "- No guest VM filesystem/VMDK scan."
  echo "- No full datastore scan or guest VM/VMDK scan."
  echo "- Current connection check only; no historical network flow visibility."
  echo "- VIB listing/signature verification are read-only; do not uninstall or remediate automatically."
  echo "- Ports 2233, 546 and VMCI 18098 are context indicators; validate against host services and baseline."
  echo "- Original collection copies /var/log and /scratch/log; runtime and storage use depend on log volume."
  echo "- Signature verification may report unavailable signatures on older/upgraded ESXi; review with known-good VIB baseline."
} >> "$REPORT"

# Include result snippets in main report for convenience.
for f in "$PATH_HITS" "$NET_HITS" "$LOG_HITS" "$STATE"; do
  echo "" >> "$REPORT"
  echo "===== $(basename "$f") =====" >> "$REPORT"
  cat "$f" >> "$REPORT"
done

# Restrict report permissions; do not alter source host configuration.
chmod 600 "$OUT_BASE"/* 2>/dev/null
:
return 0

}
run_hunt

# ==================== ARCHIVE RESULTS ==================== #
cd "$workdir" || exit 1
ARCHIVE="$output.tar.gz"
tar -czf "$ARCHIVE" "$output" 2>/dev/null
if [ -s "$ARCHIVE" ]; then
  rm -rf "$output"
  printf 'Archive created: %s\n' "$ARCHIVE"
else
  printf 'ERROR: archive creation failed; results remain in %s\n' "$output"
  exit 1
fi
exit 0
