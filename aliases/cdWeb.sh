function cdWeb() {
  cd "/home/www/$1/www" || exit
}
alias www=cdWeb