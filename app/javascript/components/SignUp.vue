<template>
  <v-container
    fluid
    fill-height>
    <v-layout
      align-center
      justify-center>
      <v-flex xs10 sm8 md8>
        <v-form ref="form" lazy-validation>
          <v-text-field
            v-model="username"
            label="Name"
            v-bind:rules="nameRules"
            required>
          </v-text-field>
          <v-text-field
            v-model="password"
            label="Password"
            v-bind:append-icon="visible ? 'visibility_off' : 'visibility'"
            v-bind:append-icon-cb="() => (visible = !visible)"
            v-bind:type="visible ? 'text' : 'password'"
            v-bind:rules="passwordRules"
            required>
          </v-text-field>
          <v-select
            v-bind:items="departments"
            item-text="name"
            item-value="id"
            label="Department"
            v-model="department"
            v-bind:rules="deptRules"
            required>
          </v-select>
          <v-text-field
            v-model="email"
            label="Email Address"
            v-bind:rules="emailRules"
            required>
          </v-text-field>
          <v-btn
            color="light-blue lighten-1"
            right
            v-on:click="signUp">
            submit
          </v-btn>
        </v-form>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import axios from 'axios'
import qs from 'qs'

export default {
  data() {
    return {
      username: '',
      nameRules: [
          v => !!v || 'Username is required',
          v => (v && v.length <= 10) || 'Name must be less than 10 characters'
      ],
      password: '',
      passwordRules: [
          v => !!v || 'Password is required',
          v => /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}$/i.test(v) || 'Passwords must contain at least one half-width alphanumeric character'
      ],
      department: '',
      deptRules: [
          v => !!v || 'Department is required'
      ],
      email: '',
      emailRules: [
          v => !!v || 'E-Mail Address is required',
          v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'E-mail Address is invalid'
      ],

      visible: false,

      // for select box
      departments: []
    }
  },
  methods: {
    signUp() {
      if (this.$refs.form.validate()) {
        axios.post('/auth', qs.stringify({
          name: this.username,
          password: this.password,
          department_id: this.department,
          email: this.email
        })).then(response => {
          this.$store.commit('SET_CURRENT_USER', response.data)
        }).catch(response => {
          console.log(response)
          throw response
        })
      }
    }
  },
  mounted: function() {
    axios.get('/departments').then(response => {
      for(let i = 0, l = response.data.length; i < l; i++) {
        this.$set(this.departments, i, response.data[i])
        console.log(response.data[i].name)
      }
    }).catch(thrown => {
      console.log(thrown)
      throw thrown
    })
  }
}
</script>

<style>

</style>
