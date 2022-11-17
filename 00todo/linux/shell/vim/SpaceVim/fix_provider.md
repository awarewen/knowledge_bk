# python 支持

install python3 and install pip 
`python3 -m ensuerpip --upgrade`

# ruby host

install ruby by RVM

- Step 1
  get RVM from [RVM.io](https://rvm.io/rvm/install)

  - install GPG keys
    `gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`

    - if you encunter problem like Server Error, try a different server
      ```
      hkp://ipv4.pool.sks-keyservers.net
      hkp://pgp.mit.edu
      hkp://keyserver.pgp.com
      ```
- Step 2
  install RVM stable with ruby
  `\curl -sSL https://get.rvm.io | bash -s stable --ruby`

- Step 3
  reload shell configuration
  `sourve ~/.rvm/scripts/rvm`

# perl host

install perl and cpanm tool

use cpanm install Neovim::Ext
`cpanm i Neovim::Ext`
