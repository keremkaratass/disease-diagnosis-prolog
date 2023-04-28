
/* PROBLEM:Belirli semptomlara göre kişinin olası hastalıklarını, tıbbi durumunu teşhis eden bir uzman sistem.
Kavramlar bir veya daha fazla sınıfa dahil edilir ve bu sınıflar arasında belirli bir dereceye sahip olabilirler. Fuzzy Logic'in amacı budur. */








% Hastalıklar
hastalik(enfeksiyon).
hastalik(ulser).

% Semptomlar
semptom(ates).
semptom(bas_agrisi).
semptom(karin_agrisi).

% Semptomların Hastalıklara Göre Olasılıkları
olasilik(ates, enfeksiyon, 0.8).
olasilik(ates, ulser, 0.2).
olasilik(bas_agrisi, enfeksiyon, 0.6).
olasilik(bas_agrisi, ulser, 0.4).
olasilik(karin_agrisi, enfeksiyon, 0.4).
olasilik(karin_agrisi, ulser, 0.6).

% Belirsizlik Yönetimi İçin Bulanık Mantık Kuralları
% (Burada örnek olarak üç semptom için 3 düzeyli bir bulanık mantık kuralları kullanılmıştır)

% Ateş
ates_yuksek(X) :- olasilik(ates, X, Y), Y >= 0.7.
ates_orta(X) :- olasilik(ates, X, Y), Y >= 0.3, Y < 0.7.
ates_dusuk(X) :- olasilik(ates, X, Y), Y < 0.3.

% Baş Ağrısı
bas_agrisi_yuksek(X) :- olasilik(bas_agrisi, X, Y), Y >= 0.7.
bas_agrisi_orta(X) :- olasilik(bas_agrisi, X, Y), Y >= 0.3, Y < 0.7.
bas_agrisi_dusuk(X) :- olasilik(bas_agrisi, X, Y), Y < 0.3.

% Karın Ağrısı
karin_agrisi_yuksek(X) :- olasilik(karin_agrisi, X, Y), Y >= 0.7.
karin_agrisi_orta(X) :- olasilik(karin_agrisi, X, Y), Y >= 0.3, Y < 0.7.
karin_agrisi_dusuk(X) :- olasilik(karin_agrisi, X, Y), Y < 0.3.

% Teşhis Kuralları
tehlikeli_hastalik(X) :- hastalik(X), olasilik(ates, X, Y), Y >= 0.7, olasilik(bas_agrisi, X, Z), Z >= 0.7.
olasilikli_hastalik(X) :- hastalik(X), olasilik(ates, X, Y), Y >= 0.4, olasilik(bas_agrisi, X, Z), Z >= 0.4.
tehlikesiz_hastalik(X) :- hastalik(X), not(tehlikeli_hastalik(X)), not(olasilikli_hastalik(X)).




/*Sorgular
Hangi hastalıklar karın ağrısı semptomu ile ilişkilendirilmiştir?
olasilik(karin_agrisi, Hastalik, Olasilik), Olasilik > 0.

Hangi hastalıkların tehlikeli olduğunu biliyoruz?
tehlikeli_hastalik(Hastalik).

Hangi hastalıkların olasılıkla olduğunu biliyoruz?
olasilikli_hastalik(Hastalik).

Hangi hastalıkların tehlikesiz olduğunu biliyoruz?
tehlikesiz_hastalik(Hastalik).

karın ağrısı semptomu ve ateş semptomunun her ikisi de en az %30 olasılıkla bir hastalığa işaret ettiği hastalıkları kontrol eder.
olasilik(karin_agrisi, Hastalik, Olasilik1), Olasilik1 >= 0.3, olasilik(ates, Hastalik, Olasilik2), Olasilik2 >= 0.3.

Karın ağrısı yüksek seviyede olan hastalıklar nelerdir?
karin_agrisi_yuksek(X), hastalik(X).

Orta seviyede baş ağrısı semptomu ve yüksek ateş semptomu olan hastaların olası hastalıklarını kontrol eder.
bas_agrisi_orta(X), ates_yuksek(X), olasilikli_hastalik(X).


Bu sorgu, ya ateşi orta seviyede olan ya da yüksek baş ağrısı semptomları olan bir hastanın, olası bir hastalığa sahip olabileceğini kontrol eder.
ates_orta(X); bas_agrisi_yuksek(X), olasilikli_hastalik(X).


düşük seviyede baş ağrısı semptomu olan hastaların veya orta seviyede karın ağrısı semptomu olan hastaların, tehlikeli bir hastalığa sahip olmayacaklarını kontrol eder.
bas_agrisi_dusuk(X); karin_agrisi_orta(X), not(tehlikeli_hastalik(X)).

Bu sorgu, yüksek ateş semptomu olan hastaların tehlikesiz bir hastalığa sahip olamayacağını kontrol eder.
ates_yuksek(X), not(tehlikesiz_hastalik(X)).

ates_dusuk(X), olasilikli_hastalik(X).

tehlikeli_hastalik(X), olasilikli_hastalik(X).*/

