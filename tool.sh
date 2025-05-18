function proxy_on() {
	export http_proxy=http://127.0.0.1:7890
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
