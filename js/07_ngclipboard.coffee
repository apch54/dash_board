###
---------------------------
 Created by apch on 11/03/2016.
---------------------------
###
angular.module('ngClipboard', []).factory('ngClipboard', ($compile, $rootScope, $document) ->
    { toClipboard: (element) ->

        copyElement = angular.element('<span id="ngClipboardCopyId">' + element + '</span>')
        body = $document.find('body').eq(0)
        body.append $compile(copyElement)($rootScope)
        ngClipboardElement = angular.element(document.getElementById('ngClipboardCopyId'))
        console.log ngClipboardElement
        range = document.createRange()
        range.selectNode ngClipboardElement[0]
        window.getSelection().removeAllRanges()
        window.getSelection().addRange range
        successful = document.execCommand('copy')
        msg = if successful then 'successful' else 'unsuccessful'
        console.log 'Copying text command was ' + msg
        window.getSelection().removeAllRanges()
        copyElement.remove()
        return
    }
).directive 'ngCopyable', ->

    link = (scope, element, attrs) ->
      element.bind 'click', ->
          range = document.createRange()
          range.selectNode document.getElementById("hidden_table")
          #console.log range
          window.getSelection().removeAllRanges()
          window.getSelection().addRange range
          successful = document.execCommand('copy')
          #msg = if successful then 'successful' else 'unsuccessful'
          #console.log 'Copying text command was ' + msg
          window.getSelection().removeAllRanges()
          return
      return

    {
    restrict: 'A'
    link: link
    }

