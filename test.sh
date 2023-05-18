script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
dotdir=$(dirname ${script_dir})
echo "$dotdir"
echo "$script_dir"
