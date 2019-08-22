import org.springframework.cloud.contract.spec.Contract

Contract.make {
    description("""
should return a fortune string
""")
    request {
        method GET()
        url "/"
    }
    response {
        status 200
        body "foo fortune"
    }
}

