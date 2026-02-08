🛡️ cPhisher - Security Awareness & Penetration Testing FrameworkcPhisher, siber güvenlik araştırmacıları ve sistem yöneticileri için geliştirilmiş, sosyal mühendislik zafiyetlerini tespit etmeyi amaçlayan bir güvenlik analiz altyapısıdır.📋 Kurulum ve Kullanım (Platformlara Göre)🐉 Kali Linux (Desktop)Standart Debian tabanlı sistemler için kurulum adımları:

Bash
# 1. Depoyu klonlayın
git clone https://github.com/CagriCoderGit/cPhisher
cd cPhisher

# 2. İzinleri tanımlayın ve bağımlılıkları kurun
chmod +x start.sh
sudo npm install -g expose # Opsiyonel: Expose tünel için

# 2. Sistemi başlatın
./start.sh

# 3. Ortamı hazırlayın
pkg update && pkg upgrade -y
pkg install -y git python php nodejs openssh


# 4. Çalıştırın (Serveo/4. seçenek önerilir)
bash start.sh

# 5. Projeyi kurun
git clone https://github.com/CagriCoderGit/cPhisher
cd cPhisher
chmod +x start.sh

# 6. Çalıştırın (Serveo/4. seçenek önerilir)
bash start.sh

🔧 Bağlantı Modülleri ve ÖzelliklerÖzellikAçıklamaPlatformArayüz SimülasyonuGerçekçi kullanıcı deneyimi testleri.HepsiServeo TünelSSH tabanlı, kurulumsuz dış erişim.Hepsi (En Stabil)LocalxposeSubdomain destekli ters proxy.Kali / TermuxCanlı LogGelen verileri anlık olarak logged.txt üzerinden izleme.Hepsi📝 Önemli Dosya Yapısıstart.sh: Tüm süreci yöneten ana kontrol paneli.index.html: Kullanıcı arayüzü test sayfası.capture.php: Veri işleme ve yönlendirme mantığı.logged.txt: Analiz verilerinin kayıt noktası.⚖️ Yasal UyarıBu araç yalnızca yasal testler ve eğitim amacıyla geliştirilmiştir. Yetkisiz kullanım tamamen kullanıcının sorumluluğundadır. Geliştirici, oluşabilecek kötüye kullanımlardan sorumlu tutulamaz.Versiyon: v1.0.2Geliştirici: CagriCoder