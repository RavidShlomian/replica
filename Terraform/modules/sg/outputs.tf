#here i will output all the values needed for other modules in the configuration

output "sg_id"{
    value = aws_security_group.sg.id
}