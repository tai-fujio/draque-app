// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage

//= require jquery3
//= require popper
//= require bootstrap-sprockets
    // boostrap & jquery はセットなのでboostrap使うときは基本上３つセット

//= require turbolinks
//= require_tree .

// js.erb 内でも使用したい変数は， let や constではなく， window.〜 や global.〜 という変数名にする必要があり。
document.addEventListener("turbolinks:load",()=>{
    const battleButton = document.getElementById("battle-button")
    const exitButton = document.getElementById("exit-button")
    window.skillButton = document.getElementById("skill-button")
    window.spellButton = document.getElementById("spell-button")
    window.battleBody = document.getElementById("battle-body")

    window.battleMonster = document.getElementById("battle-monster")
    window.battleMonsterImage = document.getElementById("battle-monster-image")
    window.battleMonsterImageBg = document.getElementById("monster-bg-image")


    window.battleMessages = document.getElementById("battle-messages")
    window.battleButtonContainer = document.getElementById("battle-button-container")
    window.exitButtonContainer = document.getElementById("exit-button-container")
    window.skillButtonContainer = document.getElementById("skill-button-container")
    window.spellButtonContainer = document.getElementById("spell-button-container")

    window.setBtn = document.getElementById("set-btn")
    window.actionBtn = document.getElementById("action-btn")

    var display = function(){
        battleButtonContainer.style.display = "none"
        exitButtonContainer.style.display = "none"
        skillButtonContainer.style.display = "none"
        spellButtonContainer.style.display = "none"
        battleMessages.innerText = ""
    }

    battleButton.addEventListener("click",() =>{
        display()
    })
    exitButton.addEventListener("click",() =>{
        display()
    })
    skillButton.addEventListener("click",() =>{
        display()
    })
    spellButton.addEventListener("click",() =>{
        display()
    })
    
})
