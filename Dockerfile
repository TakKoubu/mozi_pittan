FROM ruby:3.2.2

RUN apt-get update && apt-get install -y nodejs

RUN mkdir /mozi_pittan_game
WORKDIR /mozi_pittan_game
COPY Gemfile /mozi_pittan_game/Gemfile
RUN gem install bundler && bundle install
COPY . /mozi_pittan_game

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
