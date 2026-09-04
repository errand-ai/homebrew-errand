cask "errand-desktop" do
  version "0.5.0"
  sha256 "3479bb5691b47852f622dd5d7d119ab7b1639c1745e61a78f0105c16116a3d5f"

  url "https://github.com/errand-ai/errand-desktop/releases/download/v#{version}/ErrandDesktop.dmg",
      verified: "github.com/errand-ai/errand-desktop/"
  name "ErrandDesktop"
  desc "Menu bar app that runs the Errand stack locally in containers"
  homepage "https://github.com/errand-ai/errand-desktop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "ErrandDesktop.app"

  zap trash: [
    "~/Library/Application Support/ErrandDesktop",
    "~/Library/Preferences/sh.errand.desktop.plist",
    "~/Library/Saved Application State/sh.errand.desktop.savedState",
  ]
end
