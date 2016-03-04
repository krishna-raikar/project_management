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


User.create(firstname:'Krishna',lastname:'Raikar',phone:'',role_id:'2',email:'krishna.raikar@kvpcorp.com',password:'123456789')
User.create(firstname:'Krishna',lastname:'Raikar',phone:'',role_id:'2',email:'krishna.raikar1993@gmail.com',password:'123456789')
User.create(firstname:'varun',lastname:'nagpal',phone:'9633245155',role_id:'3',email:'varun.nagpal@gmail.com',password:'123456789')
User.create(firstname:'adminkvr',lastname:'raikar',phone:'9655152455',role_id:'1',email:'admin@gmail.com',password:'admin123')
User.create(firstname:'nataraja',lastname:'sheikh',phone:'9652415233',role_id:'2',email:'nataraj.sheikh@gmail.com',password:'123456789')
User.create(firstname:'rajendra',lastname:'kulkarni',phone:'9652441524',role_id:'2',email:'rajendra.kulkarni@gmail.com',password:'123456789')