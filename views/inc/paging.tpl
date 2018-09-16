<div class="row" style="width:100%; text-align:center;">
    <!-- Pager -->
    <ul class="pagination">

        <li>
            <a href="?{{if gt $.paging.Page 1}}page={{$.paging.Page}}-1{{else}}page=1{{end}}&pageSize={{$.paging.Pagesize}}">«</a>
        </li>
    {{if eq $.paging.PageCount 1}}
        <li  class="active">
            <span>1</span>
        </li>
    {{else}}
    {{range $k,$v:=.paging.Nums}}
        <li  class="{{if eq $v $.paging.Page}}active{{end}}">
            <a href="?page={{$v}}&pageSize={{$.paging.Pagesize}}">{{$v}}</a>
        </li>
    {{end}}
    {{end}}
        <li>
            <a href="?page={{.paging.PageCount}}&pageSize={{$.paging.Pagesize}}">»</a>
        </li>
    </ul>
</div>