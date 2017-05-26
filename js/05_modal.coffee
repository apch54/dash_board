# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *
# Modal controler
# ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ ~ ¨¨¨¨¨¨¨¨¨¨¨¨ *

window.angular.module('app_mrc').controller 'ModalInstanceCtrl', ($scope, $uibModalInstance, to_modal) ->
    $$ = $scope
    $$.modal_job = to_modal
    if $$.modal_job.job in ['Raz','Dv']
        $$.modal_job.button_style = 'background-color: MistyRose;  border-color: silver;'
        $$.modal_job.title_style = 'background-color: MistyRose;  border-color: red; color: #3333ff;'
    #show $$.modal_job.title,'to_modal'

    $scope.cancel = () ->

    #$scope.raz_filtre()
        $uibModalInstance.close 'I come from modal' #dismiss 'cancel' & send message

