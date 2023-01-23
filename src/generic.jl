function code_to_label_edges(g; with_weight=true)
    for e = edges(g)
        println(
            label_for(g, e.src), " => ", label_for(g, e.dst), " ",
            with_weight ? join(["(", g[label_for(g, e.src), label_for(g, e.dst)], ")"]) : "", 
            "\n"
        )
    end
end