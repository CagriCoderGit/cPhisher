# 🛡️ cPhisher - Security Awareness Framework v1.0.2

[![Kali Linux](https://img.shields.io/badge/Platform-Kali%20Linux-blueviolet?style=flat-square&logo=kalilinux)](https://www.kali.org/)
[![Termux](https://img.shields.io/badge/Platform-Termux-orange?style=flat-square&logo=android)](https://termux.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)

**cPhisher**, sistem yöneticileri ve siber güvenlik uzmanları için tasarlanmış, **Sosyal Mühendislik Farkındalık Analizi** süreçlerini otomatize eden modüler bir güvenlik altyapısıdır. Bu framework, kurumsal ağlardaki kimlik doğrulama zafiyetlerini tespit etmek ve tünelleme protokollerini test etmek amacıyla geliştirilmiştir.

---

## 🛠️ Kurulum ve Yapılandırma

### 🐉 Kali Linux (Desktop)
Debian tabanlı sistemlerde hızlı kurulum için aşağıdaki komut bloğunu kullanın:

```bash
# 1. Depoyu klonlayın ve dizine erişin
git clone [https://github.com/CagriCoderGit/cPhisher](https://github.com/CagriCoderGit/cPhisher)
cd cPhisher

# 2. Yetkilendirmeleri tanımlayın
chmod +x start.sh

# 3. Gerekli modülleri yükleyin (Opsiyonel)
sudo npm install -g expose 

# 4. Framework'ü başlatın
./start.sh

📱 Termux (Android)
Mobil pentest ortamı için optimize edilmiş kurulum adımları:

# 1. Paket yöneticisini güncelleyin ve gereksinimleri kurun
pkg update && pkg upgrade -y
pkg install -y git python php nodejs openssh

# 2. Projeyi sisteme dahil edin
git clone [https://github.com/CagriCoderGit/cPhisher](https://github.com/CagriCoderGit/cPhisher)
cd cPhisher

# 3. Başlatıcıyı çalıştırın
chmod +x start.sh
bash start.sh

Modül Adı,Açıklama,Platform,Durum
UI Mirroring,Yüksek doğruluklu arayüz simülasyon motoru.,Tümü,✅ Aktif
Serveo Bridge,"SSH tabanlı, kurulumsuz anlık port yönlendirme.",Tümü,🌟 Önerilen
Localxpose,Özelleştirilebilir subdomain destekli ters proxy.,Kali/Termux,✅ Aktif
Live Audit,logged.txt üzerinden gerçek zamanlı trafik izleme.,Tümü,✅ Aktif

  
