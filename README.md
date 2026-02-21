🎬 Movies App (SwiftUI + TMDb)

A modern iOS movie browsing app built with SwiftUI + MVVM, powered by the The Movie Database (TMDb) API.

🚀 Highlights

✅ Popular movies listing

🔍 Debounced movie search

🔄 Infinite scroll pagination (home + search)

❤️ Add / remove favorites (persisted via UserDefaults)

📄 Movie detail screen with genres, duration & trailer

🎥 YouTube trailer support with fallback “Watch on YouTube”

🧠 Clean MVVM architecture using async/await

🖼 Proper image loading states (no layout shifting)

🛠 Tech Stack

SwiftUI

MVVM

Async/Await

Combine

UserDefaults (local persistence)

No third-party libraries

⚙️ Setup

Clone the repository

Open in Xcode 15+

Run on iOS 17+

API Key used:

TMDB_API_KEY = 551afe9a2f39c364f840c53bfbbd7c10

📌 Assumptions

Home screen uses /popular endpoint.

Search resets to trending when cleared.

Favorites are stored locally only.

⚠️ Known Limitations

Popular API does not provide duration (not shown on home list).

Cast data not implemented (Details Screen API does not provide cast details).

YouTube embed playback may fail due to recent embed restrictions.

Added fallback “Watch on YouTube” button.

Native AVPlayer not used (YouTube streams unsupported).
