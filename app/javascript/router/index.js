import Vue from 'vue'
import Router from 'vue-router'
import Todo from '../components/Todo'
import LoginForm from '../components/LoginForm'
import SignUp from '../components/SignUp'
import store from '../store/store'

Vue.use(Router)

const router = new Router({
  routes: [
    {
      path: '/',
      name: 'todo',
      component: Todo
    },
    {
      path: '/login',
      name: 'login',
      component: LoginForm,
      beforeEnter (to, from, next) {
        if (store.getters['auth/loggedIn']) {
          next({ name: 'Todo' })
        }
        next()
      }
    },
    {
      path: '/signup',
      name: 'signup',
      component: SignUp
    }
  ]
})

router.beforeEach((to, from, next) => {
  const requiresAuth = to.matched.some(route => route.meta.requiresAuth)

  // 認証不要のルートであれば、遷移
  if (!requiresAuth) return next()

  if (store.getters.loggedIn) {
    store.dispatch('validate').then(validUser => {
      validUser ? next() : redirectToLogin()
    })
  }

  redirectToLogin()

  function redirectToLogin () {
    next({
      path: 'login',
      query: { redirect: to.fullPath }
    })
  }
})

export default router
