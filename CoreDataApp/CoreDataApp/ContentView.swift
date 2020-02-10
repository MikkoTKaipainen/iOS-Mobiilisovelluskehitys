//
//  ContentView.swift
//  CoreDataApp
//
//  Created by Mikko Kaipainen on 10/02/2020.
//  Copyright © 2020 Mikko Kaipainen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    @State private var newToDoItem = ""
    
    var body: some View {
        NavigationView{
            List {
                Section(header: Text("Next on the line?")) {
                    HStack {
                        TextField("New item", text: $newToDoItem)
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
                            toDoItem.createdAt = Date()
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.newToDoItem = ""
                        }){
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
                Section(header: Text("To Do's")) {
                    ForEach(self.toDoItems) {
                        toDoItem in ToDoItemView(title: toDoItem.title!, createdAt: "\(toDoItem.createdAt!)")
                    }.onDelete {indexSet in
                        let deleteItems = self.toDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deleteItems)
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch{
                            print(error)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("List"))
            .navigationBarItems(trailing: EditButton())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
