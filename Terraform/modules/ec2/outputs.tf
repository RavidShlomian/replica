#here i will output all the values needed for other modules in the configuration

output "instances" {
    value = aws_instance.moveo_instance.id
}