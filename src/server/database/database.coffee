Sequelize = require "sequelize"

conf = require("../../config.json").database

# TODO if dev then sqlite else mysql

db = new Sequelize conf.database, conf.username, conf.username, conf

module.exports = db
