---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## Eylemler

|          Fare         |      Dokunma     |          Eylem          |
| :-------------------: | :--------------: | :---------------------: |
| Sola tıkla ve sürükle | Dokun ve sürükle | Yeni bir alan oluşturma |
|      Ortaya tıkla     |    İki parmak    |       Tuvali taşı       |
|       Sağa tıkla      |   Uzun dokunma   |      Alanı düzenle      |

## Yapılandırma

|      Özellik | Varsayılan | Tanım                                                                                                                                                                                                                                                                                                                                                                                                                  |
| -----------: | :--------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|     Genişlik |     `0`    | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|    Yükseklik |     `0`    | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| En boy oranı |     `0`    | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

Üç farklı en boy oranı ön ayarı vardır:

- Kare (1:1)
- Dikey Sayfa (sqrt(2)) - Bu, portre durumundaki bir A4 sayfasının varsayılan en boy oranıdır.
- Yatay Sayfa (sqrt(2)) - Bu, yatay durumdaki bir A4 sayfasının varsayılan en boy oranıdır.
