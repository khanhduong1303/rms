# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.save([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.save(name: 'Emanuel', city: cities.first)
#function Condo
 p = Permission.create(per_name: "viewCondo")
 Function.create(action: "index", object: "Condo",permission_id: p.id)
 p = Permission.create(per_name: "editCondo")
 Function.create(action: "edit", object: "Condo",permission_id: p.id)
 Function.create(action: "update", object: "Condo",permission_id: p.id)
 Function.create(action: "create_image", object: "Condo",permission_id: p.id)
 p = Permission.create(per_name: "manageCondo")
 Function.create(action: "manage", object: "Condo",permission_id: p.id)
 #function Facility
 p = Permission.create(per_name: "viewFacility")
 Function.create(action: "index", object: "Facility",permission_id: p.id)
 p = Permission.create(per_name: "manageFacility")
 Function.create(action: "manage", object: "Facility",permission_id: p.id)
 # Function.create(action: "new", object: "Facility",permission_id: p.id)
 # Function.create(action: "edit", object: "Facility",permission_id: p.id)
 # Function.create(action: "timeslot", object: "Facility",permission_id: p.id)
 # Function.create(action: "add_timeslot", object: "Facility",permission_id: p.id)
 # Function.create(action: "update", object: "Facility",permission_id: p.id)
 # Function.create(action: "change_active", object: "Facility",permission_id: p.id)
 # Function.create(action: "confirm", object: "Facility",permission_id: p.id)
 # Function.create(action: "change_peak", object: "Facility",permission_id: p.id)
 # Function.create(action: "destroy", object: "Facility",permission_id: p.id)
 # Function.create(action: "create", object: "Facility",permission_id: p.id)

 #function feedback
 p = Permission.create(per_name: "viewFeedback")
 Function.create(action: "index", object: "Feedback",permission_id: p.id)
 p = Permission.create(per_name: "manageFeedback")
 Function.create(action: "manage", object: "Feedback",permission_id: p.id)
 # Function.create(action: "index_archive", object: "Feedback",permission_id: p.id)
 # Function.create(action: "destroy", object: "Feedback",permission_id: p.id)
 # Function.create(action: "destroy_multiple", object: "Feedback",permission_id: p.id)
 # Function.create(action: "move_multiple", object: "Feedback",permission_id: p.id)
 # Function.create(action: "update_reply", object: "Feedback",permission_id: p.id)
 # Function.create(action: "create_reply", object: "Feedback",permission_id: p.id)
 # Function.create(action: "move_archive", object: "Feedback",permission_id: p.id)
 # Function.create(action: "confirm_delete", object: "Feedback",permission_id: p.id)
 # Function.create(action: "reply", object: "Feedback",permission_id: p.id)
 # Function.create(action: "show_archive", object: "Feedback",permission_id: p.id)

 #function User
  p = Permission.create(per_name: "viewlistUser")
 Function.create(action: "index", object: "User" ,permission_id: p.id)
  p = Permission.create(per_name: "managelistUser")
 Function.create(action: "manage", object: "User",permission_id: p.id)


#function role
  p = Permission.create(per_name: "viewRole")
 Function.create(action: "index", object: "Role" ,permission_id: p.id)
  p = Permission.create(per_name: "manageRole")
 Function.create(action: "manage", object: "Role",permission_id: p.id)