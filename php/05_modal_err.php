<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_-->
<!-- pages modales                                                                 -->
<!-- 2015-11-28                                                                    -->
<!-- ~~~~~~~~~~~_~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_~~~~~~~~~~~_-->

        <div class="modal-header">
            <h3 style={{modal_job.modal_title_style}}>{{modal_job.title}}</h3>
        </div>
        <div class="modal-body">
            <br>{{modal_job.body}}
            <br><br>
        </div>
        <div class="modal-footer">
            <button class="btn"
                    type="button" ng-click="cancel()"
                    style = {{modal_job.button_style}}
            >
                {{modal_job.job}}
            </button>
        </div>

