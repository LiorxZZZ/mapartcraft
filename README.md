# MapartCraft

Minecraft 地圖畫產生器 - 上傳一張圖片，就能產生可以直接蓋的 **NBT 結構檔**，或可以直接放進存檔的 **map.dat**。整個工具在瀏覽器裡執行，不用下載程式，伺服器管理員和生存玩家都適用

---

## 📌 使用方式

### 產生地圖畫

1. 上傳圖片，在 **設定** 選擇遊戲 **版本** 與 **地圖大小**（以 128×128 格的地圖為單位）
2. 在 **選擇方塊** 勾選每個顏色要用哪一種方塊，或直接套用 **調色盤**（所有方塊 / 地毯 / 灰階）
3. 在 **地圖預覽** 確認效果，需要的話調整 **抖動**、**階層化**、**預處理**（亮度、對比度、飽和度）
4. 下載：
   - **下載 .nbt**：用 Litematica 或結構方塊放進世界，再照著蓋。地圖太大時可以 **分割為 1x1**
   - **下載 map.dat**：直接放進存檔的 `data/` 資料夾，不用蓋（需要能修改存檔的權限）

> 材料清單會列出每種方塊要準備幾個；勾選「只顯示每個分割區塊所需的最大材料」可以算出一張一張蓋時最多要帶多少

### 階層化（3D）

| 模式 | 說明 |
|---|---|
| 關閉 (2D) | 地圖畫是平的，最好蓋，但每種方塊只有 1 種顏色 |
| 啟用 (傳統) | 用方塊高低差產生亮、中、暗 3 種色調，可用顏色變成 3 倍 |
| 啟用 (山谷) | 地圖結果和傳統完全相同，但蓋的時候不需要往下的階梯，生存比較好蓋 |

### 透明度

勾選 **透明度** 後，圖片中的透明像素（可用 **容忍度** 調整判定範圍）：

- **map.dat**：變成顏色 0，在遊戲裡會顯示成透明
- **.nbt**：完全不放方塊

---

## 📦 安裝步驟

### Windows（推薦）

1. 安裝 [Node.js](https://nodejs.org/)，或在 PowerShell 執行
   ```powershell
   winget install OpenJS.NodeJS.LTS
   ```
2. 雙擊 `start.bat`
3. 第一次執行會自動 `npm install`，編譯完成後瀏覽器會自動開啟 http://localhost:3000/mapartcraft

### 手動

1. 安裝依賴套件
   ```bash
   npm install
   ```
2. 啟動開發伺服器，或建置正式版到 `build/`
   ```bash
   npm start
   npm run build
   ```
3. Linux 可以用 `build.sh` 建置，有 Apache 的話會一併複製 `.htaccess`

> Node.js 17 以上需要先設定環境變數 `NODE_OPTIONS=--openssl-legacy-provider`，否則會出現 `error:0308010C digital envelope routines::unsupported`。`start.bat` 已經自動設定

### 修改網址路徑

預設架設在 `https://你的網域/mapartcraft`，要換路徑時修改：

| 檔案 | 欄位 |
|---|---|
| `package.json` | `homepage` |
| `src/index.js` | Router 的 `basename` |
| `buildSources/apache/.htaccess` | `RewriteRule`（使用 Apache 時） |

---

## 🧰 新增方塊 / 版本

`tools/` 裡的 Python 腳本可以協助維護方塊資料：

| 腳本 | 說明 |
|---|---|
| `addMinecraftVersion.py` | 新增遊戲版本，並把上一版的方塊全部沿用 |
| `addColoursJSONBlock.py` | 新增方塊，可選擇一併把材質畫進 `textures.png`（需要 [ImageMagick](https://imagemagick.org/)） |
| `addColoursJSONColourSet.py` | 新增地圖顏色 |
| `addLocaleString.py` / `addLocaleLanguage.py` | 新增翻譯字串 / 語言 |

> `textures.png` 的寬度變了之後，要同步修改 `src/components/mapart/viewOnline3D/viewOnline3D.js` 的 `tileTextureWidth`，否則線上 3D 檢視的材質會錯位。格式說明在 `docs/`

---

## 📜 致謝

- 原專案 [rebane2001/mapartcraft](https://github.com/rebane2001/mapartcraft) 與所有 [貢獻者](https://github.com/rebane2001/mapartcraft/graphs/contributors)
- [SelfAdjointOperator](https://github.com/SelfAdjointOperator) 的額外功能
- Minecraft 的方塊材質
- [KenPixel Mini Square](https://opengameart.org/content/kenney-fonts) 字型，由 [Kenney](https://www.kenney.nl/) 製作
- [pako](https://www.npmjs.com/package/pako)、[jszip](https://www.npmjs.com/package/jszip) 壓縮函式庫
- [OpenMoji](https://github.com/hfg-gmuend/openmoji) 的國旗圖示
- 各語言的翻譯者（列在翻譯後的頁面上）
