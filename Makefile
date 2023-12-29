
.PHONY: rebuild
rebuild:
	# From https://stackoverflow.com/questions/24098792/how-to-force-github-pages-build
	curl -u wrp:"$${GITHUB_TOKEN:?}" \
		-X POST https://api.github.com/repos/wrp/wrp.github.io/pages/builds \
		-H "Accept: application/vnd.github.mister-fantastic-preview+json"
