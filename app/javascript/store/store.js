import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

const state = {
  cachedTasks: [],
  currentUser: getSavedState('auth.currentUser')
}

const getters = {
  // ユーザがログインしているかどうか
  loggedIn(state) {
    // javascript では"",null,undefinedはfalseとなる。
    return !!state.currentUser
  }
}

const mutations = {
  CACHE_TASKS(state, newTodo) {
    state.cachedTasks.push(newTodo)
  },
  SET_CURRENT_USER(state, newValue) {
    state.currentUser = newValue
    saveState('auth.currentUser', newValue)
    setDefaultAuthHeaders(state)
  }
}

const actions = {
  // ログイン処理
  logIn({ commit, dispatch, getters }, { username, password } = {}) {
    if (getters.loggedIn) return dispatch('validateUsersAndRefleshCache')

    return axios.post('login', { username, password })
      .then(response => {
        const user = response.data
        commit('SET_CURRENT_USER', user)
        return user
      })
  },
  // タスクを取得する
  fetchTasks({ commit, state, rootState }, { userId }) {
    axios.get(`/tasks`).then(response => {
      const tasks = response.data
      commit('CACHE_TASKS', tasks)
    })
  },
  // タスクを追加する
  addTask({ commit, state, rootState }, { task }) {
    commit('CACHE_TASKS', task)
    axios.post(`/tasks`).catch(respose => {
      // 何もしない
    })
  },

  validateUsersAndRefleshCache({ commit, state }) {
    if (!state.currentUser) return Promise.resolve(null)

    return
      axios.get('/users')
      .then(response => {
        const user = response.data
        commit('SET_CURRENT_USER', user)
        return user
      })
  }
}

function getSavedState(key) {
  return JSON.parse(window.localStorage.getItem(key))
}

function saveState(key, value) {
  window.localStorage.setItem(key, JSON.stringify(value))
}

export default new Vuex.Store({
  state,
  getters,
  mutations,
  actions
})