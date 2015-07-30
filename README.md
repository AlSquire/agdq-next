# agdq-next

A quick & dirty sinatra app scrapping https://gamesdonequick.com/schedule to display the current and 5 next speedruns. Display time in GMT+2. 

## Hubot script

If you use use Hubot (https://hubot.github.com/) as I do:

    # Description:
    #   AGDQ next schedule
    #
    # Commands:
    #   hubot agdq - Current and nexts agdq games from webservice
    #   hubot sgdq - alias for agdq
    
    module.exports = (robot) ->
      robot.respond /(agdq|sgdq)/i, (msg) ->
        msg.http("http://agdq-next.herokuapp.com/").get() (err, res, body) ->
          msg.send body
          msg.send "https://gamesdonequick.com/schedule"
