import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiles_project/todo.dart';

class TodoList extends StatefulWidget {
  @override

  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  //creat array list
  List<Todo> todos = [];
  TextEditingController controller = new TextEditingController();
  _toggleTodo(Todo todo, bool isChecked){
    setState(() {
      todo.isDone = isChecked;
    });
  }
  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];
    return CheckboxListTile(
      value:todo.isDone,
      title:Text(todo.title),
      onChanged:(bool isChecked){
        _toggleTodo(todo, isChecked);
      },
    );
  }
  
  _addTodo() async{
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('New Todo'),
          content: TextField(
            controller: controller,
            autofocus: true,
            
          ),
          actions: <Widget>[
            //button cancel
            FlatButton(
              child: Text('Cancel',style: TextStyle(color: Colors.blue),),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            //button add
            FlatButton(
              child: Text('Add',style: TextStyle(color: Colors.blue),),
              onPressed: (){
               setState(() {
                 final todo = new Todo(title:controller.value.text);
                 if(controller.value.text == ""){
                   print(" ");
                 }else{
                   
                  todos.add(todo);
                 }
                  controller.clear();
                
                  Navigator.of(context).pop();
               });
              },
            ),
          ],
        );
      }
    );

      if(todo != null){
        setState(() {
          todos.add(todo);
        });
      }
  }
  @override
  Widget build(BuildContext context) {
  
  return Scaffold(
    appBar: AppBar(
      title: Text("Todo List"),
    ),
    body: ListView.builder(
      itemBuilder: _buildItem,
      itemCount: todos.length,
    ),
    //button for add the text
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: _addTodo,
    ),
  );
}
}