import SwiftUI

struct AddTaskView: View {
    
    @State private var path = [Task]()
    @Environment(\.modelContext) var mc
    @State private var task = Task(name: "", details: "", deadline: Date(), image: "")
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedImage = "Book"
    @State private var selectedColor = Color.red
    
    var body: some View {
        VStack{
            Button{
                addTask()
                dismiss()
            }label: {
                Text("Add task")
            }
            InfoField(title: "Name", text: $task.name)
            InfoField(title: "Description", text: $task.details)
            DatePicker("Date", selection: $task.deadline)
                
            TypeView(selectedImage: $selectedImage, selectedColor: $selectedColor)
        }
        .padding(.horizontal)
    }
    
    func addTask(){
        let task = Task(name: task.name, details: task.details, deadline: task.deadline, image: selectedImage)
        mc.insert(task)
        path = [task]
    }
    
}

//
//#Preview {
//    AddTaskView()
//}
