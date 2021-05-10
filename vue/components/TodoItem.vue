<template>
	<li><span>{{name}}</span> <button @click="this.$emit('deleteSelf')">&times;</button></li>
</template>

<script>
export default {
	name: "TodoItem",
	props: {
		"name": String
	}
}
</script>
