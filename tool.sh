function lo_proxy_on() {
	ip=127.0.0.1
	export http_proxy=http://$ip:7890
	export https_proxy=$http_proxy
}

function wsl_proxy_on() {
	ip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
	export http_proxy=http://$ip:7890
	export https_proxy=$http_proxy
}

function proxy_off() {
	unset http_proxy https_proxy
}

function proxy_status() {
	echo http: $http_proxy
	echo https: $https_proxy
}


function viconf() {
	vi ~/.vimrc
}

function tmuxconf() {
	vi ~/.tmux.conf
}
