🛡️ cPhisher - Security Awareness Framework v1.0.2cPhisher, sistem yöneticileri ve güvenlik araştırmacıları için geliştirilmiş modüler bir Sosyal Mühendislik Farkındalık Analizi altyapısıdır. Bu araç, kurumsal ağlarda kullanıcıların kimlik doğrulama zafiyetlerini test etmek ve modern tünelleme protokollerini deneyimlemek amacıyla tasarlanmıştır.🛠️ Kurulum Kılavuzu🐉 Kali Linux (Masaüstü)Sisteminizi hızlıca hazır hale getirmek için terminale kopyalayın:Bash# Depoyu klonlayın ve dizine girin
git clone https://github.com/CagriCoderGit/cPhisher
cd cPhisher

# Gerekli izinleri tanımlayın
chmod +x start.sh

# Bağımlılıkları yükleyin (Expose Tünel için opsiyonel)
sudo npm install -g expose 

# Sistemi başlatın
./start.sh
📱 Termux (Android)Mobil ortamda tam performans için şu sırayı takip edin:Bash# 1. Ortamı güncelleyin ve paketleri kurun
pkg update && pkg upgrade -y
pkg install -y git python php nodejs openssh

# 2. Projeyi indirin ve yetki verin
git clone https://github.com/CagriCoderGit/cPhisher
cd cPhisher
chmod +x start.sh

# 3. Framework'ü ateşleyin
bash start.sh
🔧 Bağlantı Modülleri & Analiz ÖzellikleriÖzellikAçıklamaDesteklenen PlatformlarArayüz SimülasyonuGelişmiş UI aynalama teknolojisi ile gerçekçi testler.Kali & TermuxServeo BridgeSSH tabanlı, sıfır yapılandırma ile dış dünyaya açılma.Hepsi (Önerilen)LocalxposeÖzel subdomain desteği sunan yüksek hızlı ters proxy.Kali & TermuxReal-time Monitoringlogged.txt üzerinden canlı veri akışı ve trafik analizi.Hepsi📂 Framework Yapısıstart.sh : Orkestra Şefi - Tüm tünel ve sunucu süreçlerini yönetir.index.html : UI Katmanı - Kullanıcı etkileşim arayüzü.capture.php : Mantıksal Çekirdek - Veri işleme ve güvenli yönlendirme motoru.logged.txt : Veri Deposu - Analiz sonuçlarının yerel kayıt noktası.⚖️ Yasal Bilgilendirme[!IMPORTANT]Bu yazılım yalnızca Bilişim Etiği çerçevesinde, yetkili güvenlik testleri (Pentest) ve eğitim faaliyetleri için sunulmuştur. Bu aracın izinsiz/yasadışı kullanımı tamamen son kullanıcının sorumluluğundadır. Geliştirici (CagriCoder), oluşabilecek hiçbir yasal ihlalden sorumlu tutulamaz.Sürüm: v1.0.2Geliştirici: CagriCoderMotto: "Daha iyi bir savunma için saldırıyı anlayın."
