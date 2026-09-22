
# Control output of networking tool called ping
# 	Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# 	Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

# Show open ports
#	Use netstat command to quickly list all TCP/UDP port on the server:
alias ports='netstat -tulanp'
