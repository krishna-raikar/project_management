# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Role.create(name:'admin',description:'all accesss')
Role.create(name:'employee',description:'fdfdfd')
Role.create(name:'manager',description:'fdfff')




Permission.create(role_id:'3',modelname:'project',per_list:'["show", "edit", "create"]')
Permission.create(role_id:'1',modelname:'all',per_list:'["show", "edit", "create", "destroy", "index"]')
Permission.create(role_id:'2',modelname:'user',per_list:'["show", "edit"]')
Permission.create(role_id:'2',modelname:'task',per_list:'["show", "edit", "create", "destroy"]')
Permission.create(role_id:'2',modelname:'issue',per_list:'["show", "edit", "create", "destroy"]')
Permission.create(role_id:'2',modelname:'project',per_list:'["show", "edit"]')
Permission.create(role_id:'3',modelname:'user',per_list:'["show"]')
Permission.create(role_id:'3',modelname:'project user',per_list:'["show", "edit", "create", "destroy"]')
