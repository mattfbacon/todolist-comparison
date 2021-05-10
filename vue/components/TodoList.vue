<template>
	<div>
		<ul>
			<TodoItem v-for="(item, index) in items" :key="index" :name="item" @deleteSelf="deleteItem(index)" />
		</ul>
		<input type="text" v-model="taskInput" @keyup.enter="addTask()">
	</div>
</template>

<script>
import TodoItem from './TodoItem.vue';

export default {
	name: 'TodoList',
	data: () => ({
		items: ["Task 1", "Task 2", "Task 3"],
		taskInput: ""
	}),
	components: {
		TodoItem
	},
	methods: {
		deleteItem(index) {
			this.items.splice(index, 1);
		},
		addTask() {
			this.items.push(this.taskInput);
			this.taskInput = "";
		}
	}
}
</script>
