:
import React from 'react';


class Item extends React.Component {
    constructor(props){
        super(props);
        this.state = {
            name: props.name
        }
    }
    render(){
        return (
            <div>
                <p>
                    {this.state.name}
                </p>
                <button onClick = {this.props.removeTask} >Delete</button>
            </div>
        )
    }
}


class App extends React.Component{
    constructor(){
        super();
        this.state = {
            items:[{name: "Task 1"}, {name: "Task 2"}],
            nameValue: ""
        }
        this.handleClick = this.handleClick.bind(this);
        this.removeTask = this.removeTask.bind(this);
        this.handleChange = this.handleChange.bind(this);
    }
    
    handleChange(event) {
        this.setState({nameValue: event.target.value});
    }
    
    handleClick() {
        this.setState(({items}) => ({items: items.concat({ name: this.state.nameValue})}));
    }

    removeTask(ind) {
        this.setState(({items}) => ({items: items.filter((item, idx) => ind !== idx)}));
    }

    render(){
        return (
            <>
                {this.state.items.map((item, idx) => {
                    return <Item name={item.name} key = {item.idx} removeTask = {() => {this.removeTask(idx)}}/>
                })}
                <input onChange = {this.handleChange}>{this.nameValue}</input>
                <button onClick = {this.handleClick} >Add Task</button>
            </>
        )
    }
}

export default App;