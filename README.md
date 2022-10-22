# gpt2-text-generation.nix

Nix Flakes でバコンとやるだけでGPT-2の文字列補完であそべるやつ

## ハウツー

- Clone
- `direnv allow`
  - 3GBとかあるモデルを落としてくるのでめちゃくちゃ時間がかかる
- `python main.py`
  - すべては環境変数から渡される。詳しくはコードで
