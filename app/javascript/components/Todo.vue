<template>
  <div class="todo">
    <el-form
      ref="form"
      v-bind:model="form"
      label-position="left">
      <el-form-item label="title">
        <el-input v-model="form.title"></el-input>
      </el-form-item>

      <el-form-item label="body">
        <el-input type="textarea" v-model="form.body"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-plus"
          v-on:click="onSubmit" circle class="addButton"></el-button>
      </el-form-item>
    </el-form>

    <el-table
      v-bind:data="tableData">
      <el-table-column
        type="expand">
        <template slot-scope="props">
          <p>{{ props.row.body }}</p>
        </template>
      </el-table-column>
      <el-table-column
        label="Title"
        prop="title">
      </el-table-column>
      <el-table-column
        label="Done"
        prop="isDone">
      </el-table-column>
      <el-table-column
        label="Operations">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="info"
            v-on:click="edit(scope.$index, scope,row)">edit</el-button>
            <el-button
            size="mini"
            type="danger"
            v-on:click="remove(scope.$index, scope,row)">delete</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div >
</template>

<script>

export default {
  name: 'todo',
  data() {
    return {
      form: {
        title: '',
        body: ''
      }
    }
  },
  computed: {
    tableData () {
      return this.$store.state.cachedTasks
    }
  },
  methods: {
    onSubmit() {
      const task = {
        title: this.form.title,
        body: this.form.body
      }
      this.$store.dispatch('addTask', task)
    },
    edit(index, row) {

    },
    remove(index, row) {

    }
  },
  beforeMount: function() {
    this.$store.dispatch('fetchTasks')
  }
}
</script>

<style scoped>
  .todo {
  }

  .addButton {
    align-self: right;
  }
</style>
